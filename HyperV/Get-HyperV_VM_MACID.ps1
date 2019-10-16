$HypervServers = @("ILCSHV1","ILCSHV2")
foreach ($HypervServer in $HypervServers) {
  Get-VM -Computername $HyperVServer | Where { $_.State –eq ‘Running’ } | Get-VMNetworkAdapter | ft VMName, MacAddress, ipaddresses -AutoSize
  }