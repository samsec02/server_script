# Set the path to the shared "temp" folder
$tempFolderPath = "C:\temp"

# Get the cutoff time for files older than 24 hours
$cutoffTime = (Get-Date).AddHours(-24)

# Remove old files and empty directories
Get-ChildItem $tempFolderPath -Recurse | Where-Object { $_.LastWriteTime -lt $cutoffTime } | ForEach-Object {
    if ($_.PSIsContainer) {
        if (-not (Get-ChildItem -Path $_.FullName)) {
            Remove-Item $_.FullName -Recurse -Force
        }
    } else {
        Remove-Item $_.FullName -Force
    }
}
