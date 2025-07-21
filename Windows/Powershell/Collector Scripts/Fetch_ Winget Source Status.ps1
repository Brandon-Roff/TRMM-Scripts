#
# Script to check Winget Source Status
# By Brandon Roff
#

$wingetloc=(Get-Childitem -Path "C:\Program Files\WindowsApps" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
cd $wingetloc


#test app to see if winget souece is set
$testapp = "7zip.7zip"

#Check to see if app is avaliable under winget search 
$wingetsearch = .\winget.exe search -id $testapp
if ($wingetsearch -ne $null) {
    Write-Output "Available"
    exit 0
} else {
    Write-Output "Not Available"
    exit 1
}
