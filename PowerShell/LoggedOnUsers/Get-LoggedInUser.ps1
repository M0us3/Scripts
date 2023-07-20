Function Get-LoggedInUser {
<#
.SYNOPSIS
    This script will get the currently logged in user on a computer, note this will not include RDP sessions
 .NOTES
    Name: Get-LoggedInUser
    Author: Nick Lindstrom
    Version: 0.5
    DateCreated: 10-08-2021
 .EXAMPLE
    Get-LoggedInUser -ComputerName us-abc-123456
 .LINK 
#>
[CmdletBinding()]
   param (
     [Alias("Hostname")]
     [Parameter(Mandatory=$true)]
     [string[]]$ComputerName
    )
   try {
      Test-Connection -ComputerName $ComputerName -Count 1 -ErrorAction Stop
      Get-WmiObject -ComputerName $ComputerName -Class Win32_ComputerSystem | Select-Object UserName         
   }
   catch {
      Write-Host "The computer appears to be offline, verify the computer name"
    }
 }
