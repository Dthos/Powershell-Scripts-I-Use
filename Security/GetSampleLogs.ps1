Get-EventLog -LogName security -newest 100 | Export-Csv "$($env:computername)_datafiles\sampleauditlog.csv"