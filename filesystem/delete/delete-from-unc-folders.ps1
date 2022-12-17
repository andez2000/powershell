$files = $null
Write-Host $PSScriptRoot

$folder = "\\attesteddevnas\Music\Hayley"

$files = get-childitem -Path $folder -Include Thumbs.db -Recurse -Name -Force 

foreach ($file in $files) 
{
    $fileToDelete = [IO.Path]::Combine($folder, $file);

    Write-Host $fileToDelete

    Remove-Item $fileToDelete

}

# | foreach ($_) { Write-Host $_.Name  }

# -Force