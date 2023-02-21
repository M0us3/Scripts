# Set the OU in ldap format
$OU = "OU=,DC=compnay,DC=com"

# Create an array and get the computers that are located in the OU
$Computers = @(Get-adcomputer -filter * -searchbase $OU | fl -property Name | out-string)

# Print each computer
foreach ($computer in $computers) {
	write-host $computer
}
