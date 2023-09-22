param (
    [string]$title
)

$result = $title.ToLower()
$result = $result -replace "[^a-z0-9\s]+", ""
$result = $result -replace "\s+", "-"

$Command = "hugo.exe"
$Parms = "new content $Result.md"

$Parms = $Parms.Split(" ")
& "$Command" $Parms