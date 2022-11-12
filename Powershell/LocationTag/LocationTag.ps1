# Test computer have network connection
$Online = Test-NetConnection google.com
        
  # If computer is online, extract IP, split IP and assign to array Location.
	If ($online.PingSucceeded -eq 'True'){

      $IP = $online.SourceAddress.IPAddress
    	$Location = $IP.split(".")

        # Assign the tag based on IP location
		    switch ($location[0]) {

    		    IP {$GroupTag = ""}
    		    IP {$GroupTag = ""}
    		    IP {$GroupTag = ""}
    		    default {$GroupTag = ""}
        		    }
		}

		Else {
    		Write-Host = "Verify computer have network connection before proceeding with the install"
    		Exit-script
            }
