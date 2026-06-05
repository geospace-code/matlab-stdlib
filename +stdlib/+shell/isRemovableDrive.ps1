function IsRemovableDrive {
# Detect USB flash drive or CD / DVD drives
# If the DVD drive is empty (no media), returns false
  [CmdletBinding()]
  param (
    # Expects only a single letter (e.g., 'D' or 'E').
    [Parameter(Mandatory=$true, Position=0)]
    [ValidatePattern('^[a-zA-Z]$')]
    [string]$DriveLetter
  )

  # Format the letter into the 'D:' format.
  $deviceID = "${DriveLetter}:"

  try {

    $logicalDisk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='$deviceID'" -ErrorAction Stop

    # Write-Host $logicalDisk

    if ($logicalDisk.DriveType -eq 5) { return $true }  # CD-ROM drive

    $partition = $logicalDisk |
      Get-CimAssociatedInstance -Association Win32_LogicalDiskToPartition

    # Write-Host $partition

    $physicalDisk = $partition |
      Get-CimAssociatedInstance -Association Win32_DiskDriveToDiskPartition -ErrorAction Stop

    # Write-Host $physicalDisk
    # Write-Host "InterfaceType: $($physicalDisk.InterfaceType)"

    return ($null -ne $physicalDisk) -and ($physicalDisk.InterfaceType -eq 'USB')
  }
  catch {
    return $false
  }
}
