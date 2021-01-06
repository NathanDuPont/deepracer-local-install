Write-Host "Installing DeepRacer Offline for Windows [2]..."

Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "wsl_update_x64.msi"
Start-Process -FilePath "wsl_update_x64.msi"

(Get-Content -Path .\.windows\.temp) |
    ForEach-Object {if ($_ -Match "step=") {$_ -Replace '\d+', 3 }} |
            Set-Content -Path .\.windows\.temp

Write-Host "Please restart your machine now and run the windows-install.ps1 script to resume." -BackgroundColor DarkGreen