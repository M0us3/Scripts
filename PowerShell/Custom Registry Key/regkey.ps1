function Set-InstalledFlag {
    param (
        [Parameter(Mandatory = $true)]
        [string]$InstalledKey,

        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    # --- Manually set values here ---
    $InstalledKey = ''
    $Value = ''
    # ---------------------------------

    try {
        Get-ChildItem -Path $InstalledKey -ErrorAction Stop
        Set-ItemProperty -Path Registry::$InstalledKey -Name "Installed" -Value $Value
    }
    catch {
        New-Item -Path $InstalledKey
        Set-ItemProperty -Path Registry::$InstalledKey -Name "Installed" -Value $Value
    }
}
