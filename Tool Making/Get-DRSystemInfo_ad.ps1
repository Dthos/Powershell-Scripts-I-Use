$DRErrorLogPreference = "$home\errors.txt"
function Get-DRSystemInfo_ad {
    <#
    .SYNOPSIS
    Queries critical computer information from a single machine.
    .DESCRIPTION
    Queries OS and hardware information from a single computer. This utilizes
    WMI, so the appropriate WMI ports must be open and you must be an Admin on the 
    remote machine.
    .PARAMETER ComputerName
    The name of the computer to query. Accepts multiple values and
    accepts pipeline input.
    .PARAMETER IPAddress
    The IP address to query. Accepts multiple values but not pipeline input.
    .PARAMETER ShowProgress
    Displays a progress bar showing current operations and percent complete.
    Percentage will be inaccurate when piping computer names into the command. 
    .EXAMPLE
    .\Get-DRSystemInfo_ad -ComputerName WHATEVER
    This will query information from the computer WHATEVER
    .EXAMPLE
    .\Get-DRSystemInfo_ad -ComputerName WHATEVER | Format-Table *
    This will display the information in a table.
    .EXAMPLE
    Get-DRSystemInfo_ad -IPAddresses 10.0.0.1,10.20.30.40
    Queries computer by IPaddress instead of computer name. Does not
    accept pipeline input.
    .LINK
    http://docs.intranet/Get-DJSystemInfo.aspx
    #>
    [CmdletBinding()] #changes into advanced parameter function.
    param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True,
        ParameterSetName='computername',
        HelpMessage="Computer name to query via WMI")]
        [Alias('hostname')]
        [ValidateLength(4,14)]
        [string[]]$ComputerName,

        [Parameter(Mandatory=$True,
                   ParameterSetName='ip',
                   HelpMessage="IP address to query via WMI")]
        [ValidatePattern('(?:(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)\.){3}(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)')]
        [string[]]$IPAddress,

        [Parameter()]
        [string]$ErrorLogFilePath = $DRErrorLogPreference,
        
        [switch]$ShowProgress 
    )
    BEGIN{
        if ($PSBoundParameters.ContainsKey('ipaddress')) {
            Write-Verbose "Putting IP addresses into variable"
            $ComputerName = $IPAddress
        }
        $each_computer = (100 / ($ComputerName.Count) -as [int])
        $current_complete = 0
    }
    PROCESS{
                foreach ($computer in $ComputerName){

                    if ($computer -eq '127.0.0.1'){
                        Write-Warning "Connecting to local computer loopback!"
                    }

                if ($ShowProgress){Write-Progress -Activity "Working on $computer" -PercentComplete $current_complete}

                Write-Verbose "Connecting via WMI to $computer"
                if ($ShowProgress){Write-Progress -Activity "Working on $computer" -CurrentOperation "Operating System" -PercentComplete $current_complete}
                $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer

                if ($ShowProgress){Write-Progress -Activity "Working on $computer" -CurrentOperation "Computer System" -PercentComplete $current_complete}
                $cs = Get-WmiObject -Class win32_computersystem -ComputerName $computer

                Write-Verbose "Finished with WMI, building output"
                if ($ShowProgress){Write-Progress -Activity "Working on $computer" -CurrentOperation "Creating output" -PercentComplete $current_complete}
                $props = @{'ComputerName' = $computer;
                           'OSVersion' = $os.version;
                           'OSBuild' = $os.buildnumber;
                           'SPVersion' = $os.servicepackmajorversion;
                           'Model' = $cs.model;
                           'Manufacturer' = $cs.manufacturer;
                           'RAM' = $cs.totalphysicalmemory; 
                           'Sockets' = $cs.numberofprocessors;
                           'Cores' = $cs.numberoflogicalprocessors;
                           'SystemType' = $cs.SystemType;
                           'Domainship' = $cs.Domain}
                $obj = New-Object -TypeName PSObject -Property $props
                
                Write-Verbose "Outputting to pipeline"
                Write-Output $obj

                Write-Verbose "Done with $computer"
                $current_complete += $each_computer
                if ($ShowProgress){Write-Progress -Activity "Working on $computer" -PercentComplete $current_complete}
                }
            }
            END{
                if ($ShowProgress){Write-Progress -Activity "Done" -Completed}
            }
}
#help Get-DRSysteminfo_ad
#Get-DRSystemInfo_ad -ComputerName ILCSDC0,ILCSDC1
#'CRITHOS','localhost','ILCSDC0','ILCSDC1' | Get-DRSystemInfo_ad
#import-csv .\comps.csv | Get-DRSystemInfo_ad
# Pipe in strings from only one place.
#$WarningPreference='SilentlyContinue'
#Get-DRSystemInfo_ad -ComputerName ILCSDC0,ILCSDC1,ILCSRCA,ILCSICA -ShowProgress:$false
#help Write-Progress has a variable $ProgressPreference. You can show sseconds remaining or %complete.
#Get-DRSystemInfo_ad -IPAddress 127.0.0.1, 10.11.10.2
#help about_comment_based_help
#.LINK related topic or URI to online help version.
