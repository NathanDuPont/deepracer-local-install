$step = @(Get-Content -Path .\.windows\.temp -Filter step=*) -replace '\D', ''

If ($step -eq 1) {
    $val = Read-Host "Do you already have WSL 2 installed? (Y/n)"
}

If ($val -Match "^[Yy]") {
    $step = 3
} 

Switch($step) 
{
    1 { Invoke-Expression -Command ".\.windows\windows-1.ps1" }
    2 { Invoke-Expression -Command ".\.windows\windows-2.ps1" }
    3 { Invoke-Expression -Command ".\.windows\windows-3.ps1" }
}