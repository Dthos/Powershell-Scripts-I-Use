$Header = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
"@
get-hotfix | Where-Object {$_.installedon -gt (get-date).addmonths(-6)} | Sort-Object -property installedOn -Descending | Select installedon, Description, Hotfixid |ConvertTo-HTML -Head $Header | Out-File "$($env:computername)_datafiles\hotfixes.htm"