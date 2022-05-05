# Purpose: Simple demo on how to pass array parameters to a powershell script.
#
# Examples:
#
#    Call:
#         .\PassArrayParametersToScript.ps1 -p2 5,6,7
#
#    Output:
#        p1:
#        p2: 5 6 7
#
#    Call:
#         .\PassArrayParametersToScript.ps1 -p1 1,2,3
#
#    Output:
#        p1: 1 2 3
#        p2: 
#    Call:
#         .\PassArrayParametersToScript.ps1 -p1 1,2,3 -p2 5,6,7
#
#    Output:
#        p1: 1 2 3
#        p2: 5 6 7
param (
    [array] $p1,
    [array] $p2
)

Write-Host "p1: " $p1
Write-Host "p2: " $p2

