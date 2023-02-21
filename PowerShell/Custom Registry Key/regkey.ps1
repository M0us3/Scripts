# Set the path
$InstalledKey = ''

# Test the path if it doesn't exist create it. Installed software value is 1, change it to 0 for application uninstalled
try {
	Get-ChildItem -Path $InstalledKey -ErrorAction Stop
	Set-ItemProperty -Path Registry::$InstalledKey -Name "Installed" -Value 1
}
catch {
	New-Item -Path $InstalledKey
	Set-ItemProperty -Path Registry::$InstalledKey -Name "Installed" -Value 1
}
