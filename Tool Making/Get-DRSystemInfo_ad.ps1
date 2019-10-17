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
    .EXAMPLE
    .\Get-DRSystemInfo_ad -ComputerName WHATEVER
    This will query information from the computer WHATEVER
    .EXAMPLE
    .\Get-DRSystemInfo_ad -ComputerName WHATEVER | Format-Table *
    This will display the information in a table.
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
        [string]$ErrorLogFilePath = $DRErrorLogPreference 
    )
    BEGIN{
        if ($PSBoundParameters.ContainsKey('ipaddress')) {
            Write-Verbose "Putting IP addresses into variable"
            $ComputerName = $IPAddress
        }
    }
    PROCESS{
                foreach ($computer in $ComputerName){
                Write-Verbose "Connecting via WMI to $computer"
                $cs = Get-WmiObject -Class win32_computersystem -ComputerName $computer
                $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer

                Write-Verbose "Finished with WMI, building output"
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
                }
            }
            END{}
}
#help Get-DRSysteminfo_ad
#Get-DRSystemInfo_ad -ComputerName ILCSDC0,ILCSDC1
#'CRITHOS','localhost','ILCSDC0','ILCSDC1' | Get-DRSystemInfo_ad
#import-csv .\comps.csv | Get-DRSystemInfo_ad
# Pipe in strings from only one place.
Get-DRSystemInfo_ad -IPAddress 127.0.0.1, 10.11.10.2 -Verbose
 
