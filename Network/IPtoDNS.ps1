Get-Content C:\Users\drios\Documents\1_Scripts\IP_Address.txt | ForEach-Object {([system.net.dns]::GetHostByAddress($_)).hostname >> c:\hostname.txt}