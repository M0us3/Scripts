$Computers = ''

foreach ($computer in $computers) {

	$pingtest = test-connection -computername $computer -count 1 -Quiet -erroraction SilentlyContinue
    if ($pingtest){
     $servicestatus = (Get-Service -name wuauserv | fl -property Name, Status, StartType | out-string)
    write-host $computer $servicestatus
    }
    else {Write-Host($Computer + " is offline")}
}
