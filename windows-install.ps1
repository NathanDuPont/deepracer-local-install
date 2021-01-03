$step = @(Get-Content -Path .\.windows\.temp -Filter step=*) -replace '\D', ''

Switch($step) 
{
    1 { Invoke-Expression -Command ".\.windows\windows-1.ps1" }
    2 { Invoke-Expression -Command ".\.windows\windows-2.ps1" }
}