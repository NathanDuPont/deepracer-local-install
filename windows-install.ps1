function Install-CommandIfNotInstalled {
    param (
        [String][Parameter(Mandatory=$true)]$PackageName,
        [String][Parameter(Mandatory=$true)]$CheckCommand,
        $InstallCommand
    )

    If (Get-Command $CheckCommand -ErrorAction SilentlyContinue) {
        Write-Host "$PackageName Already Installed. Proceeding..." -BackgroundColor DarkGreen
    } Else {
        Write-Host "$PackageName Not Found. Installing..." -BackgroundColor DarkGreen
        & $InstallCommand
    }
}

$step = @(Get-Content -Path .\.windows\.temp -Filter step=*) -replace '\D', ''

$str = ""

If ($step -eq 1) {    
    Install-CommandIfNotInstalled -PackageName "Chocolatey" -CheckCommand "choco" -InstallCommand { Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) }
    Install-CommandIfNotInstalled -PackageName "Docker" -CheckCommand "docker" -InstallCommand { choco install -y docker-desktop }
    Install-CommandIfNotInstalled -PackageName "Docker-Compose" -CheckCommand "docker-compose" -InstallCommand { choco install -y docker-compose }

    If (Get-Command "wsl" -ErrorAction SilentlyContinue) {
        Write-Host "wsl Already Installed. Proceeding..." -BackgroundColor DarkGreen
        $step = 2
    } Else {
        Write-Host "wsl Not Found. Installing..." -BackgroundColor DarkGreen
    }
}

If ($step -eq 2) {
    @(wsl -l -v) | ForEach-Object {if ($_ -Replace [char]0, "" -Match "Ubuntu-20.04") { $str=@($_ -Replace "\D+").Substring(4) }} 

    If ($str -eq 2) {
        $step = 3;   
    } 
}

Switch($step) 
{
    1 { Invoke-Expression -Command ".\.windows\windows-1.ps1" }
    2 { Invoke-Expression -Command ".\.windows\windows-2.ps1" }
    3 { Invoke-Expression -Command ".\.windows\windows-3.ps1" }
}