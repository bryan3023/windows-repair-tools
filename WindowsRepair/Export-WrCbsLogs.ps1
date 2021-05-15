
function Export-WrCbsLogs {
    [CmdLetBinding()]
    Param(
        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime] $StartTime
    ,
        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime] $ExitTime
    ,
        [Parameter(ValueFromPipeline)]
        $PipelineInput
    )

    PROCESS {
        New-TimeSpan -Start $StartTime -End $ExitTime
    }
}