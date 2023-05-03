# -------- Network Settings --------
# Set Network Cards Power Management OFF
# Function will be called in the loop, use the function to modify, add or make changes to the settings
Function Set-NetRegistry{
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "PnPCapabilities" -Type DWord -Value 24
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "AutoPowerSaveModeEnabled" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "ReduceSpeedOnPowerDown" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "EnablePME" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "ULPMode" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "EEELinkAdvertisement" -Value 0
}

$RegPath="HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"
$SubKey=0000

While($SubKey -lt 0021){
try {
	New-Item -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -ErrorAction Stop
	Set-NetRegistry
}
catch {
    Set-NetRegistry
	}
finally {
	$SubKey++
	}
}
