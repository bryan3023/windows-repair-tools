#Requires -RunAsAdministrator

[CmdletBinding()]
Param(
    [Parameter(Mandatory,ParameterSetName='InstallMedia')]
    [string] $InstallMediaIsoPath
,
    [Parameter(Mandatory,ParameterSetName='WimFile')]
    [string] $WimFilePath
,
    [Parameter(ParameterSetName='InsallMedia')]
    [Parameter(ParameterSetName='WimFile')]
    [int] $ImageIndex
)

BEGIN {
    Set-StrictMode -Version 3.0

    [string] $StagingFolder = "$PSScriptRoot/staging"

    if (-not (Test-Path -LiteralPath $StagingFolder)) {
        New-Item -Path $StagingFolder -ItemType Directory -Force | Out-Null
    }

    if ($InstallMediaIsoPath) {
        if (-not (Test-Path -LiteralPath $InstallMediaIsoPath)) {
            Write-Error "Install Media ISO not found."
        } else {
            $InstallDisk = Mount-DiskImage -ImagePath $InstallMediaIsoPath -Access ReadOnly -StorageType ISO -PassThru
            $InstallDiskVolumeRoot = "{0}:\" -f ($InstallDisk | Get-Volume).DriveLetter
            $WimFilePath = Join-Path -Path $InstallDiskVolumeRoot -ChildPath "sources\install.wim"

            if (-not (Test-Path -Path $WimFilePath)) {
                Write-Error "Install.wim not found. This ISO is not valid Windows installation media!"
            } else {
                Write-Host "Found install.wim!"
            }
        }
    }
}

PROCESS {
    $Images = Get-WindowsImage -ImagePath $WimFilePath

    if (-not $ImageIndex -and $Images.Count -gt 1) {
        Write-Host "`nMultiple images found. Please choose one that matches the edition you need to repair:`n"

        $Images | ForEach-Object -Process {
            $line = "{0}. {1}`n{2}`n" -f
                $PSItem.ImageIndex,
                $PSItem.ImageName,
                $PSItem.ImageDescription
            Write-Host $line
        }
        $ImageIndex = Read-Host -Prompt "Enter the index number"
    }

    Start-Sleep -Seconds 10
}

END {
    $InstallDisk | Dismount-DiskImage | Out-Null
}
