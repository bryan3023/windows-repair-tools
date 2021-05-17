$RemoteCredentials = $null

function Test-WinPE {
    $MiniNtKey = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlset\Control\MiniNT"
    return Test-Path -Path $MiniNtKey
}

function Test-ServerCore {

    [CmdletBinding()]
    Param(
        [string] $ComputerName = $env:COMPUTERNAME
    )

    $InvokeTestServerCore = @{
        ScriptBlock = {
            $NtCurrentVersionKey = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
            return (Get-ItemProperty $NtCurrentVersionKey).InstallationType -eq "Server Core"
        }
    }

    if ($ComputerName -ne $env:COMPUTERNAME) {
        $InvokeTestServerCore['ComputerName'] = $ComputerName
        $InvokeTestServerCore['Credential'] = (Get-RemoteCredentials)
    }

    return (Invoke-Command @InvokeTestServerCore)
}

function Get-RemoteCredentials {
    if (-not $RemoteCredentials) {
        $Prompt = @{
            Message = "Please enter credentials with administative access to the remote system."
        }

        if ($PSVersionTable.PSVersion -ge [version]"6.0") {
            $Prompt['Title'] = "Credentials for Remote Machine"
        }

        $RemoteCredentials = Get-Credential @Prompt
    }
    return $RemoteCredentials
}
