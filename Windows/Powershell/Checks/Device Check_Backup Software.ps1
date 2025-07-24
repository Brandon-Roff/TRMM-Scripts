function Get-LastModified {
    param ($Path)
    if (Test-Path $Path) {
        try {
            return (Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue |
                Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime
        } catch {
            return $null
        }
    }
    return $null
}

function Format-Status {
    param (
        [string]$Name,
        [bool]$Installed,
        [string]$Path,
        $LastModified
    )


    $status = if ($Installed) { "Installed" } else { "Not Installed" }
    $modified = if ($LastModified) { $LastModified.ToString("yyyy-MM-dd HH:mm") } else { "N/A" }

    Write-Host "---- $Name ----"
    Write-Host "Status       : $status"
    Write-Host "Sync Folder  : $Path"
    Write-Host "Last Activity: $modified"
    Write-Host ""
}

$clients = @{}

# OneDrive
$exe = "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe"
$path = "$env:USERPROFILE\OneDrive"
if (Test-Path "HKCU:\Software\Microsoft\OneDrive") {
    $reg = Get-ItemProperty -Path "HKCU:\Software\Microsoft\OneDrive" -ErrorAction SilentlyContinue
    if ($reg.UserFolder) { $path = $reg.UserFolder }
}
$clients.OneDrive = @{
    Name = "OneDrive"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# Google Drive
$path = "$env:USERPROFILE\Google Drive"
$altPath = "$env:LOCALAPPDATA\Google\DriveFS"
$clients.GoogleDrive = @{
    Name = "Google Drive"
    Installed = (Test-Path $path) -or (Test-Path $altPath)
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# Dropbox
$exe = "$env:LOCALAPPDATA\Dropbox\Client\Dropbox.exe"
$path = "$env:USERPROFILE\Dropbox"
$clients.Dropbox = @{
    Name = "Dropbox"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# iDrive
$exe = "$env:ProgramFiles\IDriveWindows\IDriveTray.exe"
$path = "$env:ProgramData\IDrive"
$clients.IDrive = @{
    Name = "iDrive"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# Datto Workplace
$exe = "$env:ProgramFiles\Datto Workplace\WorkplaceDesktop.exe"
$path = "$env:USERPROFILE\Datto Workplace"
$clients.DattoWorkplace = @{
    Name = "Datto Workplace"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# Backblaze
$exe = "$env:ProgramFiles(x86)\Backblaze\bzbui.exe"
$path = "$env:ProgramData\Backblaze"
$clients.Backblaze = @{
    Name = "Backblaze"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# pCloud
$exe = "$env:LOCALAPPDATA\pCloud\pCloud.exe"
$path = "$env:USERPROFILE\pCloud Drive"
$clients.pCloud = @{
    Name = "pCloud"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# MEGA
$exe = "$env:LOCALAPPDATA\MEGAsync\MEGAsync.exe"
$path = "$env:USERPROFILE\MEGA"
$clients.MEGA = @{
    Name = "MEGA"
    Installed = Test-Path $exe
    SyncFolder = $path
    LastModified = Get-LastModified -Path $path
}

# Output
Write-Host ""
Write-Host "Cloud Backup Client Status Report"
Write-Host "================================"
Write-Host ""

foreach ($client in $clients.GetEnumerator()) {
    Format-Status -Name $client.Value.Name `
        -Installed $client.Value.Installed `
        -Path $client.Value.SyncFolder `
        -LastModified $client.Value.LastModified
}