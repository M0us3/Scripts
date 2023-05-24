$Path = Read-host "Enter the file path"

try {
    Test-Path -Path $Path -ErrorAction Stop
    Write-Host "${Path} found"
    $InstalledVersion = $(Get-ItemProperty -Path $Path).VersionInfo.FileVersion
    Write-Host $InstalledVersion
}
catch {
    Write-Verbose -Message "${Path} not found"
}
