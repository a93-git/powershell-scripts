$Service = 'MSSQLSERVER'
$CacheFolderName = 'test folder 2'

# Stop the service
Get-Service -Name $Service | Stop-Service -Force -WarningAction SilentlyContinue

# Get current service status
$ServiceStatus = Get-Service $Service | Select-Object Status -ExpandProperty Status

# Wait for the service to stop
$Count = 0
While($Count -ne 60) {
    if ( $ServiceStatus -eq "Stopped" ) {
        Write-Host "Service has been stopped"
        break
    } else {
        Start-Sleep(60)
        $Count = $Count + 1
    }
}

# Backup of the cache
$Date = Get-Date -format dd-MM-yyyy
$CopyFromPath = "C:\Users\Administrator\Documents\test folder\test folder 2"
$CopyToPath = $CopyFromPath + $Date

Try {
    $BackupDirParent = Split-Path $CopyFromPath
    New-Item -ItemType 'directory' -Path $BackupDirParent -Name "$CacheFolderName$Date" -ErrorAction Stop | Out-Null
    Move-Item -Path "$CopyFromPath\*" -Destination "$CopyToPath\" -Force -InformationAction SilentlyContinue -ErrorAction Stop
#    $MoveAttempt = $True
}
Catch {
    "Unable to move the files"
#    $MoveAttempt = $False
}

# Start the service
Start-Service -Name $Service

# Confirm if the service is running
$ServiceStatus = Get-Service $Service | Select-Object Status -ExpandProperty Status
$Count = 0
While ($Count -ne 60) {
	if ( $ServiceStatus -eq "Running" ) {
        Write-Host "Service has been started"
	    break
	} else {
		Start-Sleep(60)
		$Count = $Count + 1
	}
}