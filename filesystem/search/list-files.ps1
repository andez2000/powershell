# dir /s /b *.mp3 > list.txt
Get-ChildItem -Recurse -Filter *.mp3 | Select-Object -ExpandProperty FullName | Out-File -File list.txt