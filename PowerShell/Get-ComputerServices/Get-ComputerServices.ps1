function Get-ComputerService {
    param (
        [string]$computers
        [string]$service
    )

foreach ($computer in $computers) {

	$pingtest = test-connection -computername $computer -count 1 -Quiet -erroraction SilentlyContinue
    if ($pingtest){
     $servicestatus = (Get-Service -name $service | fl -property Name, Status, StartType | out-string)
    write-host $computer $servicestatus
    }
    else {Write-Host($Computer + " is offline")}
}
    
}
