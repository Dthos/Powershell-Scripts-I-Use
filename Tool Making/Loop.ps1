$i = 0
do {
    # something
    echo "$i"
    $i++
} while ($i -lt 10)

$i = 0
do {
    # something
    echo "$i"
    $i++
} until ($i -gt 9)


# do {# something} until (condition) 
# do {all contents execute at least one time.} 

$i = 10
while ($i -lt 10) {  #this will never execute.
    #something
    $i++
}
help about_do -ShowWindow
help about_while -ShowWindow

# for a fixed number of times

#for(startcondition; continued condition; action everyloop ) {
#}

for ($i=0; $i -lt 10; $i++){
    echo $i
}

$i = 0
do {
    # something
    echo "$i"
    $i++
    if ($i -eq 5){echo "$i Whoa!" ; break}
} while ($i -lt 10)