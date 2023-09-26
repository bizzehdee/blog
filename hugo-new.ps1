param (
    [string]$title
)

$shortWords = @("the", "a", "in", "on", "is", "and", "for", "of")

$result = $title.ToLower()

$words = $result -split '\s+' | Where-Object { $_ -notin $shortWords }

$result = $words -join ' '

$result = $result -replace "[^a-z0-9\s]+", ""
$result = $result -replace "\s+", "-"

$Command = "hugo.exe"
$Parms = "new $Result.md"

$Parms = $Parms.Split(" ")
& "$Command" $Parms