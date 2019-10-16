Write-Host "Exporting GPOs...PLEASE WAIT"
Get-GPO -All | %{
    Get-GPOReport -name $_.displayname -ReportType html -path ("script_output\gpo\"+$_.displayname+".html")
}