
# Set the path to the shared "temp" folder
$tempPath = ""  

# Get the cutoff time for files older than 24 hours
$layTime = (Get-Date).AddHours(-24)

# Get all items in the temp folder and loop through them
Get-ChildItem $tempPath -Recurse | ForEach-Object {

    # Remove empty directories immediately
    if ($_.PSIsContainer -and (Get-ChildItem $_.FullName | Measure-Object).Count -eq 0) {
        Remove-Item $_.FullName -Recurse -Force  # Remove empty directory
    }

    # Check if the item is older than 24 hours
    if ($_.LastWriteTime -lt $layTime) {
        Remove-Item $_.FullName -Recurse -Force  # Remove file or non-empty directory
    }
}
