param (
    [string] $msiurl,
    [string] $switches = "/qn"
)

$downloadpath = "C:\Temp\"
$ErrorCount = 0

if (-not (Test-Path -Path $downloadpath)) {
    Write-Host "Creating directory $downloadpath"
    New-Item -Path $downloadpath -ItemType Directory
}

$msifile = $msiurl.Split("/")[-1]
$msifilepath = Join-Path -Path $downloadpath -ChildPath $msifile

# Ensure the URL is valid
try {
    $uri = [System.Uri]::new($msiurl)
} catch {
    Write-Host "Invalid URL: $msiurl"
    Exit 1
}

# Download the MSI file
Write-Host "Downloading $msiurl to $msifilepath"
try {
    Invoke-WebRequest -Uri $msiurl -OutFile $msifilepath -ErrorAction Stop
} catch {
    Write-Host "Failed to download the MSI file."
    Exit 1
}

# Function to get the Product Code from an MSI file
function Get-MsiProductCode {
    param (
        [string]$msiFilePath
    )

    $productCode = $null

    try {
        # Create COM object and open the MSI database
        $windowsInstaller = New-Object -ComObject WindowsInstaller.Installer
        $database = $windowsInstaller.OpenDatabase($msiFilePath, 0)

        if ($null -eq $database) {
            throw "Failed to open MSI database."
        }

        # Query for the ProductCode from the Property table
        $query = "SELECT * FROM Property WHERE Property = 'ProductCode'"
        $view = $database.OpenView($query)
        $view.Execute()

        $record = $view.Fetch()
        if ($null -eq $record) {
            throw "Failed to fetch the ProductCode from the MSI database."
        }

        # Retrieve and clean up the ProductCode
        $productCode = $record.StringData(2)
        

        Write-Host "Extracted Product Code: $productCode"
    }
    catch {
        Write-Error "An error occurred: $_"
    }
    finally {
        # Clean up COM objects
        if ($null -ne $view) {
            $view.Close()
            [System.Runtime.Interopservices.Marshal]::ReleaseComObject($view) | Out-Null
        }
        if ($null -ne $database) {
            [System.Runtime.Interopservices.Marshal]::ReleaseComObject($database) | Out-Null
        }
        if ($null -ne $windowsInstaller) {
            [System.Runtime.Interopservices.Marshal]::ReleaseComObject($windowsInstaller) | Out-Null
        }
        # Force garbage collection
        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
    }

    return $productCode
}

# Function to reverse a GUID (used for HKEY_CLASSES_ROOT\Installer\Products\)
function ConvertTo-ReversedGuid {
    param (
        [string]$guid
    )

    $parts = $guid -split '-'
    $reversedGuid = (
        $parts[0][6..7] + $parts[0][4..5] + $parts[0][2..3] + $parts[0][0..1] +
        $parts[1][2..3] + $parts[1][0..1] +
        $parts[2][2..3] + $parts[2][0..1] +
        $parts[3] + 
        $parts[4]
    ) -join ''

    return $reversedGuid
}

# Get the Product Code
$productCode = Get-MsiProductCode -msiFilePath $msifilepath
if (-not $productCode) {
    Write-Host "Failed to extract the Product Code from the MSI file."
    Exit 1
}

Write-Host "Product Code: $productCode"
$productCode = $store

# Install the MSI file
$logFile = "$downloadpath\install.log"
Write-Host "Installing $msifilepath"
try {
    $installArgs = "/i `"$msifilepath`" $switches /L*V `"$logFile`""
    Start-Process msiexec.exe -ArgumentList $installArgs -Wait -NoNewWindow
} catch {
    Write-Host "Failed to install $msifile"
    Exit 1
}

# Check installation log for errors
$logContent = Get-Content $logFile -Raw
if ($logContent -match "Error 1722" -or $logContent -match "Error 1603") {
    Write-Host "Installation failed. Check the log file for details: $logFile"
    Exit 1
}

# Check if the MSI was installed successfully using the Product Code and checking the registry in multiple locations
$registryPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$productCode",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$productCode",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$productCode",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$productCode"
)

$installed = $false

# Check in the standard and WOW6432Node uninstall paths
foreach ($regPath in $registryPaths) {
    if (Test-Path $regPath) {
        Write-Host "Found Product Code in registry path: $regPath"
        $installed = $true
        break
    }
}

# If not found, check in HKEY_CLASSES_ROOT\Installer\Products\
if (-not $installed) {
    $reversedGuid = ConvertTo-ReversedGuid -guid $productCode
    $regPath = "HKCR:\Installer\Products\$reversedGuid"
    if (Test-Path $regPath) {
        Write-Host "Found Product Code in reversed registry path: $regPath"
        $installed = $true
    }
}

if ($installed) {
    Write-Host "$msifile installed successfully"
    Exit 0
} else {
    Write-Host "$msifile failed to install"
    Exit 1
}
