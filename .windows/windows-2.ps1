Write-Host "Installing DeepRacer Offline for Windows [2]..."

Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "wsl_update_x64.msi"
Start-Process -FilePath "wsl_update_x64.msi"

Read-Host "Press any key once the popup WSL installation has completed"

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
Write-Host "Search for 'Ubuntu 20.04' in Windows Search, and open the application. It will set up your environment."
Read-Host "Once the set up is complete, return here and press any key to continue"

wsl 

sudo ./linux-install.sh