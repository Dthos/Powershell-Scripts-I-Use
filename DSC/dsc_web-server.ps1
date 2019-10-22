# configuration
Configuration IISConfig {

        #resource
        WindowsFeature IIS {

            Ensure = "Present"
            Name = "Web-Server"
        }


}

# create configuration (.mof)
IISConfig -ComputerName WEB-NUG -OutputPath C:\nuggetlab

#push the configuration to WEB-NUG
# LCM local configuration manager
# mof managed object framework

Start-DscConfiguration -Path C:\nuggetlab -Wait -Verbose