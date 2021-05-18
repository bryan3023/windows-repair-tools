
function Export-WrCbsLogs {
    [CmdLetBinding()]
    Param(
        [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='Subset')]
        [datetime] $StartTime
    ,
        [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='Subset')]
        [datetime] $ExitTime
    ,
        [Parameter(ValueFromPipeline,ParameterSetName='Subset')]
        $PipelineInput
    ,
        [Parameter(ParameterSetName='All')]
        [switch] $All
    ,
        [Parameter(ParameterSetName='All')]
        [Parameter(ParameterSetName='Subset')]
        [string] $LogPath
    )

    PROCESS {
        New-TimeSpan -Start $StartTime -End $ExitTime
    }
}