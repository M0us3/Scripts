#
# Script to find location based on IP range and assign it to a tag that can be used in location parameters.
# This example uses the second octet in the network id. 
# Replace "ChangeToIP" with the correct ip range in the Switch.
# 

# Ping site to verify network connection
$Online = Test-NetConnection site.com

	# Extract the IP address, split the address using . as the delimiter and assign to Location array
	If ($online.PingSucceeded -eq 'True'){
    	$IP = $online.SourceAddress.IPAddress
    	$Location = $IP.split(".")

		# Assign tag based on the second octet 
		switch ($location[1]) {
		
    		ChangeToIP {$LocationTag = "Europe"}
    		ChangeToIP {$LocationTag = "Asia"}
    		ChangeToIP {$LocationTag = "NorthAmerica"}
    		default {$LocationTag = ""}
        		}
		}
		
		# If ping fails write error
		Else {
    		Write-Host = "Verify computer have network connection before proceeding with the install"
    		Exit-Script
		}
