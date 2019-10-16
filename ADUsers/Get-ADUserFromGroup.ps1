$groupname = Get-Content -Path $home\Documents\groups.txt

$table = foreach($group in $groupname){
$users = Get-ADGroupMember -Identity $group | Where-Object {$_.objectclass -eq "user"}
foreach ($activeusers in $users) { Get-ADUser -Identity $activeusers -Properties * | Where-Object {$_.enabled -eq $true} | 
Select-Object name,samaccountname,@{N='Group'; E={$group}}, LastLogonDate }
}

$table | Format-Table -AutoSize