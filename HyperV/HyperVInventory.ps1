$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@
$RemoteComputers = @("ILCSHV1","ILCSHV2","ILCSHV3","ILCSV4","ILCSV5","ILCSHVND1","ILCSHVND2")

$output = ForEach ($Computer in $RemoteComputers)
{
Invoke-Command -ComputerName $Computer -ScriptBlock {
$vmrunning = get-vm | Where-Object {$_.state -eq 'running'} 
$vmIP = $vmrunning | Get-VMNetworkAdapter | Select-Object -ExpandProperty IPAddresses
$vmMac =$vmrunning | Get-VMNetworkAdapter | Select-Object -ExpandProperty MacAddress
$vmrunning | Sort-Object Uptime | 
Select-Object Name,Uptime,@{N="MemoryMB";E={$_.MemoryAssigned/1MB}},@{N="IPAddresses";E={$vmIP}},@{N="MacAddress";E={$vmMac}},Status} -ErrorAction SilentlyContinue  
}

$output | ConvertTo-Html -Head $Header | Out-File -FilePath $home\Documents\Critsol.net.Inventory.HyperV.html 
$output | Export-Csv -Path $home\Documents\Critsol.net.Inventory.HyperV.csv