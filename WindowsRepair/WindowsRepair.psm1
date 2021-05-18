Set-StrictMode -Version 3.0

$PublicExports = Get-ChildItem -Path "$PSScriptRoot\*.ps1"
$PublicExports | ForEach-Object -Process {
    . $PSItem.FullName
}
