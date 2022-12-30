#
# Simple to script to get users that are logged in to a remote computer, note this will not include RDP sessions
# .Example
# Get-LoggedInUSer -Computername computername
#    
Function Get-LoggedInUser {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ComputerName
    )
        
        # Ping the computer to make sure it is online, if it does not respond display error
        If (Test-Connection -ComputerName $ComputerName -Count 1 -ErrorAction SilentlyContinue) {
			
			Write-Host "The computer is online"
			
            # Get the currently logged in user
            Get-WmiObject -ComputerName $ComputerName -Class Win32_ComputerSystem | Select-Object UserName
        }
            else {
             {Write-Host "The computer appears to be offline, verify the computer name"}
            
    }
 }
