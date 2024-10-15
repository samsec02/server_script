# Set the path to the shared "temp" folder
$tempPath = ""  

# Get the cutoff time for files older than 24 hours
$layTime = (Get-Date).AddHours(-24)

# Get all items in the temp folder and loop through them
Get-ChildItem $tempPath -Recurse | ForEach-Object {
    # Check if the item is older than 24 hours
    if ($_.LastWriteTime -lt $layTime) {
        # Remove the item if it's a file or an empty directory
        if ($_.PSIsContainer -and (Get-ChildItem $_.FullName | Measure-Object).Count -eq 0) {
            Remove-Item $_.FullName -Recurse -Force  # Remove empty directory
        } elseif (-not $_.PSIsContainer) {
            Remove-Item $_.FullName -Force  # Remove file
        }
    }
}
