(Get-Content -Path .\.windows\.temp) |
    ForEach-Object {if ($_ -Match "step=") {$_ -Replace '\d+', 3 }} |
            Set-Content -Path .\.windows\.temp

Write-Host "Installing DeepRacer Offline for Windows [3]..."

wsl --set-default-version 2

$str = ""

@(wsl -l -v) | ForEach-Object {if ($_ -Replace [char]0, "" -Match "Ubuntu-20.04") { $str=@($_ -Replace "\D+").Substring(4) }} 

if ($str -eq 1) {
    Write-Host "Ubuntu 20.04 is Installed, but on WSL 1. Converting to WSL 2..."
    wsl --set-version Ubuntu-20.04 2
} elseif ($str -eq 2) {
    Write-Host "Ubuntu 20.04 is Installed and on WSL 2."
} else {
    Write-Host "Ubuntu 20.04 isn't installed. Installing Chocolatey and Ubuntu 20.04..."
    choco install -y wsl-ubuntu-2004 --params "/InstallRoot:true"
}

Write-Host "DO NOT CLOSE THIS WINDOW!"
Write-Host "If the previous install failed, press [Control]+[C] and re-run the windows-install.ps1 script. If still failing, go to the Windows Store and search for 'Ubuntu 20.04', and install before continuing."
Write-Host ""
Write-Host "After successful install, search for 'Ubuntu 20.04' in Windows Search, and open the application. It will set up your environment."
Read-Host "Once the set up is complete, return here and press any key to continue"

wsl 

sudo ./linux-install.sh