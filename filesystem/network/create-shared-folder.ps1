#
# Purpose: Creates a network shared folder.
#
Clear-Host

$fullFolderPath = "G:\SharedFolder"

#
# Create Folder
#

if (Test-Path -LiteralPath $fullFolderPath -PathType Container) {
    Write-Host "Folder '$fullFolderPath' already exists"
} else {
    Write-Host "Creating folder $fullFolderPath"
    New-Item $fullFolderPath -Type Directory
}

#
# Create Share
#

# double slashes '\\' for path separators
$queryFolder = $fullFolderPath.Replace("\", "\\")

if ([bool](Get-WmiObject -Class Win32_Share -Filter "Path='$queryFolder'")) {
    Write-Host "Folder is already shared"
} else {
    New-SmbShare -Name "FolderShare" -Path $fullFolderPath -Description "Shared Folder for testing report data" -FullAccess "Administrators" #, "MSNOOB\MS-RDS1$" 
}

 