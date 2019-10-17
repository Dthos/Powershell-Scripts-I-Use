$x = 5 # dollar sign means get contents of variable
Remove-Variable -name $x
Remove-Variable -name x #this deletes the variable

${this is a legal variable name although I don't recommend it} = 'wow'
${computer name}
$ComputerName #Stick with variable names without spaces.

help about_variables -ShowWindow
