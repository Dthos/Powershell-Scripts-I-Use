# enter a powershell session on a remote machine 
Enter—PSSession  -ComputerName CORE-NUG 
# view all available features 
Get-WindowsFeatures 
# install web server (iss) role and management service 
Install-WindowsFeature —Name Web—server, Web-Mgmt—Service 
# view installed features 
Get-WindowsFeature | Where-Object Installed —eq True 
# configure remote management for IIS 
Set-Itemproperty -Path "HKLM:Software\Microsoft\WebManagement\Server" -Name "Enable RemoteManagement" -Value 1
# configure remote managent service to start automatical Iy 
Set-Service WMSVC —StartupType Automatic 
# rename a computer 
Rename—Computer -NewName WEB—NUG —DomainCredential "nuggetlab\administrator" -force -restart 
# exit remote powershell session 
Exit-PSSession 

# send a command over to a remote machine (powershell remoting — http) 
Invoke—command —ComputerName WEB—NUG —Scriptblock { Get-Service W3SVC, WMSVC } 
# use the built in computername parameter (windows — dcom) 
Get-Service -Computer Name WEB-NUG 