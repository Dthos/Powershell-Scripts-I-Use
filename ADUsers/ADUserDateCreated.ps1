Import-module activedirectory

$DaysActive = 90
$domain = "critsol.net"
$time = (Get-Date).Adddays( - ($DaysActive)) 



Get-ADUser -Filter { LastLogonTimeStamp -gt $time -and enabled -eq $true } -Properties DisplayName,whenCreated,memberof |
ForEach-Object {
    $Name = $_.DisplayName
    $datec = $_.whenCreated
    $_.memberof | Get-ADGroup | Select-Object @{N = "User"; E = { $Name } }, Name, @{N = "Created"; E = {$datec}}
} | export-csv $home\Documents\$domain.Domain_Users_Create_Date.$((Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')).csv –notypeinformation