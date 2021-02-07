$ht=@{}  # initialize empty hashtable
dir "\\attesteddevnas\Music\hayley-archive\*.mp3" -r -file | Foreach {$ht["$($_.Name):$($_.Length)"] = $_.FullName}
dir "\\attesteddevnas\Music\Hayley\*.mp3" -r file | Foreach {$ht.Remove("$($_.Name):$($_.Length)")}
$ht  # dump remaining hashtable contents
