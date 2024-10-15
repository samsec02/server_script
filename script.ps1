# Set the path to the shared "temp" folder
$tempFolderPath = "C:\temp"

# Get the current time minus 24 hours
$cutoffTime = Get-Date -Hour 1 -Minute 30 -Day $((Get-Date).Day - 1)

# Get a list of files and directories older than 24 hours
$oldFiles = Get-ChildItem $tempFolderPath -Recurse | Where-Object {$_.LastWriteTime -lt $cutoffTime}

# Remove the old files and directories
foreach ($file in $oldFiles) {
    if ($file.IsContainer) {
        Remove-Item $file -Recurse -Force
    } else {
        Remove-Item $file -Force
    }
}