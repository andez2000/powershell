###############################################################################
#
# Filename: copy-folder.ps1
#
# Purpose:  Copy a specified folder and contents to a new location
#
# Parameters:
#   $sourceRoot - the source folder
#   $destinationRoot - the destination folder  
#
# Usage:
#   & '.\copy-folder.ps1' -sourceRoot C:\src -destinationRoot C:\dest
#
###############################################################################
param
(
  [String]$sourceRoot = '',
  [String]$destinationRoot = ''
)

if ($sourceRoot -eq '') {
    Write-Output "Please specify a source folder";
    Exit;
}

if ($destinationRoot -eq '') {
    Write-Output "Please specify a destination folder";
    Exit;
}

Write-Output "Copying ""$sourceRoot"" to ""$destinationRoot"""

Copy-Item -Path $sourceRoot -Filter "*.*" -Recurse -Destination $destinationRoot -Container