switch($status) {
    0{ $real_status = 'Printer OK' } #0 is $status
    1{ $real_status = 'Printer Jammed' }
    2{ $real_status = 'Printer Out of Paper' }
    default { $real_status = 'Printer Unknown Status' }
}

$servername = "BOSDC01"
switch -Wildcard ($servername) {
    "*DC*"{ 'Server is a DC' } # DC is checked
    "BOS*"{ 'Server is in Boston' }
    "LAX*"{ 
        'Server is in LA'
         break
         }
    "*FS*"{ 'Server is a file server' }
}

$servername = "BOSDC01"
switch -Wildcard ($servername) {
    "*DC*"{ 'Server is a DC' } # DC is checked
    "BOS*"{ 'Server is in Boston' }
    "LAX*"{ 'Server is in LA'; break} #will not jump out of if/elseif
    "*FS*"{ 'Server is a file server'}
}

 # switch -Regex

<#switch(){

}
#>
#help about switch

# Everything executes.
