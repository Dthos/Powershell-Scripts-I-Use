$Header = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
"@

. scripts\.\Get-RemoteAppliedGPOs.ps1
$a = Get-RemoteAppliedGPOs
$a.AppliedGPOs | Select Name,AppliedOrder,Enabled | Sort-Object AppliedOrder | ConvertTo-Html -head $header | Out-File "$($env:computername)_datafiles\$($env:computername)_AppliedGPOs.htm"
#$a = Get-RemoteAppliedGPOs
#       $a.AppliedGPOs | 
#            Select Name,AppliedOrder |
#            Sort-Object AppliedOrder