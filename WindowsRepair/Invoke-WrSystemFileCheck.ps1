#Requires -RunAsAdministrator

Set-StrictMode -Version 3.0

function Invoke-WrSystemFileCheck {

    [CmdletBinding()]
    Param()

    BEGIN {
        . "$PSScriptRoot\util\SystemContext.ps1"
    }

    PROCESS {
        $InvokeSfc = @{
            FilePath = "$env:SystemRoot\System32\sfc.exe"
            ArgumentList = '/scannow'
            NoNewWindow = $true
            PassThru = $true
            Wait = $true
        }
        $Process = Start-Process @InvokeSfc

        $Result = [PSCustomObject] @{
            FilePath = $InvokeSfc.FilePath
            ArgumentList = $InvokeSfc.ArgumentList
            ExitCode = $Process.ExitCode
            StartTime = $Process.StartTime
            EndTime = $Process.ExitTime
        }
    }

    END {
        Write-OutPut $Result
    }
}
