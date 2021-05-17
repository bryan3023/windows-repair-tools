[CmdletBinding()]
Param(
    $LogFile = "$env:SystemRoot\Logs\DISM\DISM.log"
)

# $DismLog = Get-Content -Path $LogFile

# $DismLog | ? {$PSItem -like "*, Warning*"} | Select -Last 100