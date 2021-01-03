Write-Host "Installing DeepRacer Offline for Windows [1]..."

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Checking if WSL 2 can be installed

$MajorVersion = [System.Environment]::OSVersion.Version.Major
$BuildVersion = [System.Environment]::OSVersion.Version.Build
$RevisionVersion = [System.Environment]::OSVersion.Version.Revision

Write-Host "Running Windows $MajorVersion Build $BuildVersion.$RevisionVersion"

If ($MajorVersion -ge 10 -and $BuildVersion -ge 18362) {
    Write-Host "This machine is compatible with WSL 2. Installing..." -BackgroundColor DarkGreen
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
} Else {
    Write-Host "This machine is not compatible with WSL 2. Installing WSL 1..." -BackgroundColor DarkBlue
}

(Get-Content -Path .\.windows\.temp) |
    ForEach-Object {if ($_ -Match "step=") {$_ -Replace '\d+', 2 }} |
            Set-Content -Path .\.windows\.temp
        
Write-Host "Please restart your machine now and run the windows-install.ps1 script to resume."