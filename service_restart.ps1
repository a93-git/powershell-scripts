# 1. Stop the service
Stop-Service -Force -Name "PerfHost"

# 1(a) Check if the service has been stopped

$service_status = Get-Service "PerfHost" | Select-Object Status -ExpandProperty Status

While (1) {
	if ( $service_status -eq "Stopped" ) {
        Write-Host "Service has been stopped"
		break
	} else {
		sleep(60)
	}
}
	
# 2. Clear the cache
Get-ChildItem -Path "C:\Users\Administrator\Documents\files_to_delete\*" | Remove-Item

# 3. Start the service

Start-Service -Name "PerfHost"

# 3(a) Check if the service is running
$service_status = Get-Service "PerfHost" | Select-Object Status -ExpandProperty Status
$count = 0
While ($count -ne 45) {
	if ( $service_status -eq "Running" ) {
        Write-Host "Service has been started"
	    break
	} else {
		sleep(60)
		$count = $count + 1
	}
}