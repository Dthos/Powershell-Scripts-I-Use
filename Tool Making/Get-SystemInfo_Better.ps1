<#
.SYNOPSIS
Queries critical computer information from a single machine.
.DESCRIPTION
Queries OS and hardware information from a single computer. This utilizes
WMI, so the appropriate WMI ports must be open and you must be an Admin on the 
remote machine.
.PARAMETER ComputerName
The name or IP address of the computer to query.
.EXAMPLE
.\Get-SystemInfo_Better -ComputerName WHATEVER
This will query information from the computer WHATEVER
.EXAMPLE
.\Get-SystemInfo -ComputerName WHATEVER | Format-Table *
This will display the information in a table.
#>
param(
    [string]$ComputerName = 'localhost'
)
$cs = Get-WmiObject -Class win32_computersystem -ComputerName $ComputerName

$os = Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName

$props = @{'ComputerName' = $ComputerName;
           'OSVersion' = $os.version;
           'OSBuild' = $os.buildnumber;
           'SPVersion' = $os.servicepackmajorversion;
           'Model' = $cs.model;
           'Manufacturer' = $cs.manufacturer;
           'RAM(GB)' = $cs.totalphysicalmemory / 1GB -as [int]; #to drop fractional
           'Sockets' = $cs.numberofprocessors;
           'Cores' = $cs.numberoflogicalprocessors}
$obj = New-Object -TypeName PSObject -Property $props
Write-Output $obj