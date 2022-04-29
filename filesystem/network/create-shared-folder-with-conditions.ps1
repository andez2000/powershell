#
# Purpose: Creates a network shared folder.
#
# Notes: We use a technique called splatting to verify whether configuration is setup for conditional arrays.
#

Clear-Host

$fullFolderPath = "G:\SharedFolder"
$fullAccess = @("Administrators", "andez")
$readAccess = $null # @()

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

function CreateHashTablePropertyIfArrayHasValues([hashtable] $hashParams, [string] $paramName, [array] $arrValues) {
    
    if ($arrValues -ne $null -and $arrValues.Count -ne 0)
    {
        $hashParams[$paramName] = $arrValues
    }
}



# double slashes '\\' for path separators
$queryFolder = $fullFolderPath.Replace("\", "\\")

if ([bool](Get-WmiObject -Class Win32_Share -Filter "Path='$queryFolder'")) {
    Write-Host "Folder is already shared"
} else {
    $params =  @{            
        Name           = "The share"
        Path           = $fullFolderPath
        Description    = "Shared Folder for testing report data"
    }

    CreateHashTablePropertyIfArrayHasValues $params "FullAccess" $fullAccess
    CreateHashTablePropertyIfArrayHasValues $params "ReadAccess" $readAccess
        
    New-SmbShare @params
}

Write-Host "Done!" 