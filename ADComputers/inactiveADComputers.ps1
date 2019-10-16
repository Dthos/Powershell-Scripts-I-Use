Import-module activedirectory

$DaysInactive = 90

$time = (Get-Date).Adddays(-($DaysInactive))

Get-ADComputer -Filter {(LastLogonTimeStamp -lt $time) -and (Enabled -eq $true)} -Properties Name, OperatingSystem, SamAccountName, DistinguishedName,lastlogondate | 

export-csv $home\Documents\Output\Critsol.net_Domain_Inactive_Computers_User_$((Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')).csv –notypeinformation