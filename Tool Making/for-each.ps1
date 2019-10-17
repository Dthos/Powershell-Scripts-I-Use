$services = Get-Service

foreach ($service in $services) { #service will refer to each object in Variable, arbitrary variable.
    $service.name
}

get-service | foreach { $_.name}
#$_ built in variable. 
#get-service | get-member