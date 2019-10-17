<#
Scope = system of containerization

#>


Write-Host "Beggining script execution"
Write-Host "x contains $x"

Write-Host "Now setting x"
$x = 5
Write-Host "x contains $x"

function Scope {

    Write-Host "Inside of function Scope"
    Write-Host "x contains $x"
    $Script:x = 500
    $global:x = 10000
    $x = 10
    Write-Host "x contains $x"
    Write-Host "Finished function scope"
    Set-Variable -name x -value 5123 -Scope global
}

Write-Host "Executing Scope function"
Scope
Write-Host "Finished Scope function"
Write-Host "Back in the Script"
Write-Host "x contains $x"

Write-Host "Now messing with global scope"
$global:x = 200
Write-Host "x contains $x" #still in script scope
$x = 500
Write-Host "x contains $x"
# Global = input
# script = 5
# function = 10

<#
Governed by scope:
    variable
    aliases
    psdrives
    pssnapins

Parent-Child terms for scope. 
Powershell always starts in the current scope and goes up the tree through parents
until it hits the global.
Each scope is held separately. 
Once the scope is done executing, it is destroyed. 
Parents can't see into children scope


#>
<# PS C:\Users\chezrios.CRIT\Documents\Learning> $x = 100                                                            PS C:\Users\chezrios.CRIT\Documents\Learning> .\scopetest.ps1                                                     Beggining script execution
x contains 100
Now setting x
x contains 5
Executing Scope function
Inside of function Scope
x contains 5
x contains 10
Finished function scope
Finished Scope function
Back in the Script
x contains 5
PS C:\Users\chezrios.CRIT\Documents\Learning> $x  
100
PS C:\Users\chezrios.CRIT\Documents\Learning> 
#>
