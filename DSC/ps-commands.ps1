### USE THIS FOR DESIRED STATE CONFIGURATION ###
### (separate code fbelow for LCM configuration)

# Create a DSC Configuration to install IIS and support remote management
#resources for IIS Settings https://www.powershellgallery.com/packages/xWebAdministration/1.17.0.0
Configuration IISConfig {

    # define input parameter

    param(
        [string[]]$ComputerName = 'localhost'
    )

    # target machine(s) based on input param
    Node $ComputerName {

        #configure the LCM
        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 15
            RefreshMode = "Push"
        }

        # install the IIS server role
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Server"
        }

        #install the IIS remote management service
        WindowsFeature IISManagement {
            Name = 'Web-Mgmt-Service'
            Ensure = 'Present'
            DependsOn = @('[WindowsFeature]IIS')
        }

        # enable IIS remote management
        Registry RemoteManagement {
            Key = 'HKLM:\SOFTWARE\Microsoft\WebManagement\Server'
            ValueName = 'EnableRemoteManagement'
            ValueType = 'Dword'
            ValueData = '1'
            DependsOn = @('[WindowsFeature]IIS','[WindowsFeature]IISManagement')
        }

        # configure remote management service
        Service WMSVC {
        Name = 'WMSVC'
        StartupType = 'Automatic'
        State = 'Running'
        DependsOn = '[Registry]RemoteManagement'
        }
    }
}

# create the configuration (.mof)
IISConfig -ComputerName WEB-NUG -OutputPath C:\nuggetlab

# push the configuration to WEB-NUG
Start-DscConfiguration -Path C:\nuggetlab -Wait -Verbose


# enter powershell remote session
Enter-PSSession -ComputerName WEB-NUG

#view installed features
Get-WindowsFeature | Where-Object Installed -EQ True

# view LCM properties
Get-DscLocalConfigurationManager

# view configuration state
Get-DscConfigurationStatus

# test configuration drift
Test-DscConfiguration

# exit powershell remote session
Exit-PSSession
