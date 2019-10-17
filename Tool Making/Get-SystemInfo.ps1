<#
First the command
Then a simple script
Then a parameterized script
then a script with help
then a simple function
#>

# Get-WMIObject -List| Where{$_.name -match "^Win32_"} | Sort Name | Format-Table Name
#$cs = Get-WmiObject -Class win32_operatingsystem -ComputerName localhost | fl *

$cs = Get-WmiObject -Class win32_computersystem -ComputerName localhost

$os = Get-WmiObject -Class win32_operatingsystem -ComputerName localhost

$props = @{'ComputerName' = 'localhost';
           'OSVersion' = $os.version;
           'OSBuild' = $os.buildnumber;
           'SPVersion' = $os.servicepackmajorversion;
           'Model' = $cs.model;
           'Manufacturer' = $cs.manufacturer;
           'RAM' = $cs.totalphysicalmemory / 1GB -as [int]; #to drop fractional
           'Sockets' = $cs.numberofprocessors;
           'Cores' = $cs.numberoflogicalprocessors}
$obj = New-Object -TypeName PSObject -Property $props
Write-Output $obj