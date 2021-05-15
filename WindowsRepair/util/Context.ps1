function Test-WinPE {
    $MiniNtKey = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlset\Control\MiniNT"
    return Test-Path -Path $MiniNtKey
}