#
#	execution-policy
#
#



# view
Get-ExecutionPolicy -List

# run script with unrestricted
powershell.exe -ExecutionPolicy Unrestricted -File test.ps1

# in-process only
#	scope:		remains active until console is closed.  
#	advantages: you can run in a console before running you files
Set-ExecutionPolicy Unrestricted -Scope Process

# current user
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

