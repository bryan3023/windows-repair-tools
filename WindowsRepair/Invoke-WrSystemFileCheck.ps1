#Requires -RunAsAdministrator

function Invoke-WrSystemFileCheck {

    [CmdletBinding()]
    Param()

    BEGIN {
        . "$PSScriptRoot\util\Context.ps1"
    }

    PROCESS {
        $InvokeSfc = @{
            FilePath = "$env:SystemRoot\System32\sfc.exe"
            ArgumentList = '/scannow'
            NoNewWindow = $true
            PassThru = $true
            Wait = $true
        }

        $Result = Start-Process @InvokeSfc
    }

    END {
        Write-OutPut $Result
    }
}