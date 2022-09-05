$ht=@{}  # initialize empty hashtable
dir "\\attesteddevnas\Music\Hayley\pure-energy-go\archives*.zip" -r -file | Foreach {$ht["$($_.Name):$($_.Length)"] = $_.FullName}
dir "\\attesteddevnas\Music\hayley-archive\pure-energy\archives\*.zip" -r file | Foreach {$ht.Remove("$($_.Name):$($_.Length)")}
$ht  # dump remaining hashtable contents
