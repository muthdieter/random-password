        
        Clear-Host

$ScriptName = "random password"
$scriptVersion = "V_1_0_1"
$scriptGitHub = "https://github.com/muthdieter"
$scriptDate = "7.2025"

mode 300

Write-Host ""
Write-Host "             ____  __  __"
Write-Host "            |  _ \|  \/  |"
Write-Host "            | | | | |\/| |"
Write-Host "            | |_| | |  | |"
Write-Host "            |____/|_|  |_|"
Write-Host "   "
Write-Host ""
Write-Host "       $scriptGitHub " -ForegroundColor magenta
Write-Host ""
Write-Host "       $ScriptName   " -ForegroundColor Green
write-Host "       $scriptVersion" -ForegroundColor Green
write-host "       $scriptDate   " -ForegroundColor Green
Write-Host ""
Pause
Write-Host ""
Write-Host ""

        Write-Host "#######################################"-ForegroundColor Green 
        Write-Host "# no char :num (0);lower(l)           #"-ForegroundColor Green 
        write-Host "#######################################"-ForegroundColor Green 
        write-host ""
        write-host ""
        write-host ""
        $lengthin = Read-Host "          how long        " 
        $upperin =  Read-Host "    how much upper char   "
        $lowerin =  Read-Host "    how much lower char   "
        $numericin = Read-Host "   how much numeric char "
        $specialin = Read-Host "   how much special char "

function Get-RandomPassword {
    param (
        [Parameter(Mandatory)]
        [ValidateRange(4,[int]::MaxValue)]
        [int] $length = $lengthin ,
        [int] $upper = $upperin,
        [int] $lower =  $lowerin,
        [int] $numeric = $numericin,
        [int] $special = $specialin
    )
    if($upper + $lower + $numeric + $special -gt $length) {
        throw "number of upper/lower/numeric/special char must be lower or equal to length"
    }
    $uCharSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $lCharSet = "abcdefghijkmnopqrstuvwxyz"
    $nCharSet = "123456789"
    $sCharSet = "/*-+,!?=()@;:._"
    $charSet = ""
    if($upper -gt 0) { $charSet += $uCharSet }
    if($lower -gt 0) { $charSet += $lCharSet }
    if($numeric -gt 0) { $charSet += $nCharSet }
    if($special -gt 0) { $charSet += $sCharSet }
    
    $charSet = $charSet.ToCharArray()
    $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $bytes = New-Object byte[]($length)
    $rng.GetBytes($bytes)
 
    $result = New-Object char[]($length)
    for ($i = 0 ; $i -lt $length ; $i++) {
        $result[$i] = $charSet[$bytes[$i] % $charSet.Length]
    }
    $password = (-join $result)
    $valid = $true
    if($upper   -gt ($password.ToCharArray() | Where-Object {$_ -cin $uCharSet.ToCharArray() }).Count) { $valid = $false }
    if($lower   -gt ($password.ToCharArray() | Where-Object {$_ -cin $lCharSet.ToCharArray() }).Count) { $valid = $false }
    if($numeric -gt ($password.ToCharArray() | Where-Object {$_ -cin $nCharSet.ToCharArray() }).Count) { $valid = $false }
    if($special -gt ($password.ToCharArray() | Where-Object {$_ -cin $sCharSet.ToCharArray() }).Count) { $valid = $false }
 
    if(!$valid) {
         $password = Get-RandomPassword $length $upper $lower $numeric $special
    }
    return $password
}
""
""
Get-RandomPassword             $lengthin 
write-host ""
write-host ""
Write-Host "              #     you see       #"-ForegroundColor Green 
write-host ""
pause