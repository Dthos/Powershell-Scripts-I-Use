$age = read-host "Enter your age"
#if(){}

if ($age -lt 18) {
    write-host "You are under 18"
} elseif ($age -lt 55) {
    Write-Host "You are under 55"
} elseif ($age -lt 60) {
    Write-Host "You are under 60"
} else {
    Write-Host "You are 60 or over"
}

# help about_if* -showwindow
# Keep