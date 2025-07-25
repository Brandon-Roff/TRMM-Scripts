Write-Host "===== TPM Status ====="

try {
    $tpm = Get-Tpm -ErrorAction Stop
    if ($tpm.TpmPresent) {
        Write-Host ("{0,-20}: {1}" -f "TPM Present", "Yes")
        Write-Host ("{0,-20}: {1}" -f "Manufacturer", $tpm.ManufacturerIdTxt)
        Write-Host ("{0,-20}: {1}" -f "Version", $tpm.ManufacturerVersion)
        Write-Host ("{0,-20}: {1}" -f "Provisioned", $tpm.TpmReady)
    } else {
        Write-Host "TPM not present"
    }
} catch {
    Write-Host "Error checking TPM: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "===== BitLocker Status ====="

$bitlockerReported = $false

if (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue) {
    try {
        $bitlocker = Get-BitLockerVolume -MountPoint "C:" -ErrorAction Stop
        $bitlockerReported = $true

        $status = $bitlocker.ProtectionStatus

        # Normalize the output to plain text descriptions
        if ($status -eq 0 -or $status -eq "Off") {
            Write-Host ("{0,-20}: {1}" -f "Protection", "Available but not enabled")
        }
        elseif ($status -eq 1 -or $status -eq "On") {
            Write-Host ("{0,-20}: {1}" -f "Protection", "Enabled")
        }
        elseif ($status -eq 2) {
            Write-Host ("{0,-20}: {1}" -f "Protection", "Unknown or partially encrypted")
        }
        else {
            Write-Host ("{0,-20}: {1}" -f "Protection", "Unrecognized status ($status)")
        }

    } catch {
        Write-Host "Error checking BitLocker with Get-BitLockerVolume: $($_.Exception.Message)"
    }
}

if (-not $bitlockerReported) {
    try {
        $volumes = Get-WmiObject -Namespace "root\CIMV2\Security\MicrosoftVolumeEncryption" -Class Win32_EncryptableVolume
        if ($volumes.Count -gt 0) {
            Write-Host ("{0,-20}: {1}" -f "BitLocker (WMI)", "Available")
        } else {
            Write-Host ("{0,-20}: {1}" -f "BitLocker (WMI)", "Not supported")
        }
    } catch {
        Write-Host "Error checking BitLocker with WMI: $($_.Exception.Message)"
    }
}
