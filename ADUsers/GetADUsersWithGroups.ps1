Get-ADUser -Filter 'enabled -eq $true' -Properties SamAccountname,DisplayName,memberof | % {
    New-Object PSObject -Property @{
    UserName = $_.DisplayName
    oSamAccountname= $_.SamAccountname
    Groups = ($_.memberof | Get-ADGroup | Select -ExpandProperty Name) -join 
    ","}
    } | Select oSamAccountname,UserName,Groups |
    export-csv $home\Documents\Output\All_users_$((Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')).csv –notypeinformation