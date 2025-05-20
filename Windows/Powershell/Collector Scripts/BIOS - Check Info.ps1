<#
.SYNOPSIS
    BIOS Information Checker Script

.DESCRIPTION
    Retrieves and displays BIOS information using Get-CimInstance.
    Handles null/invalid ReleaseDate values gracefully.
    Exits with 0 if successful, 1001 on script failure, and 1002 if no BIOS data is found.

.NOTES
    Author: Brandon Roff
    Date: 2025-05-20
    Version: 1.1
#>

Try {
    $biosInfo = Get-CimInstance -ClassName Win32_BIOS

    if ($biosInfo) {
        $releaseDate = $null
        if ($biosInfo.ReleaseDate -and $biosInfo.ReleaseDate.Length -ge 14) {
            try {
                $releaseDate = [System.Management.ManagementDateTimeConverter]::ToDateTime($biosInfo.ReleaseDate)
            } catch {
                $releaseDate = "Invalid or unconvertible date"
            }
        } else {
            $releaseDate = "Unavailable"
        }

        Write-Host "`n=== BIOS Information ===" -ForegroundColor Cyan
        Write-Host "Status:               $($biosInfo.Status)"
        Write-Host "Primary BIOS:         $($biosInfo.PrimaryBIOS)"
        Write-Host "SMBIOS BIOS Version:  $($biosInfo.SMBIOSBIOSVersion)"
        Write-Host "SMBIOS Major Version: $($biosInfo.SMBIOSMajorVersion)"
        Write-Host "SMBIOS Minor Version: $($biosInfo.SMBIOSMinorVersion)"
        Write-Host "Manufacturer:         $($biosInfo.Manufacturer)"
        Write-Host "Release Date:         $releaseDate"

        Write-Host "`nBIOS check passed." -ForegroundColor Green
        Exit 0
    }
    else {
        Write-Host "No BIOS information found." -ForegroundColor Yellow
        Exit 1002
    }
}
Catch {
    Write-Host "Script check failed: $($_.Exception.Message)" -ForegroundColor Red
    Exit 1001
}
