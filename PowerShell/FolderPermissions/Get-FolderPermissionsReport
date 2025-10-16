function Get-FolderPermissionsReport {
    param (
        [string]$FolderPath = $([Management.Automation.WildcardPattern]::Escape($(Read-Host "Enter the folder path to scan").Trim('"')))
        [string]$ExportDirectory = $([Management.Automation.WildcardPattern]::Escape($(Read-Host "Enter the file name and path for the export (e.g., C:\Path\To\Export\PermissionsReport.csv)").Trim('"')))
    )

    # Validate folder path
    if (-not (Test-Path -Path $FolderPath -PathType Container)) {
        Write-Host "Invalid folder path: $FolderPath" -ForegroundColor Red
        return
    }

    # Validate export directory's parent folder
    $exportParent = Split-Path -Path $ExportDirectory -Parent
    if (-not (Test-Path -Path $exportParent -PathType Container)) {
        Write-Host "Invalid export directory: $ExportDirectory" -ForegroundColor Red
        return
    }

    $Directory = Get-ChildItem -Directory -Path $FolderPath -Recurse -Force
    $Report = @()

    foreach ($Folder in $Directory) {
        $Acl = Get-Acl -Path $Folder.FullName
        foreach ($Access in $Acl.Access) {
            $Properties = [ordered]@{
                'FolderName'         = $Folder.FullName
                'AD Group or User'   = $Access.IdentityReference
                'Permissions'        = $Access.FileSystemRights
                'Inherited'          = $Access.IsInherited
            }
            $Report += New-Object -TypeName PSObject -Property $Properties
        }
    }

    $Report | Export-Csv -Path $ExportDirectory -NoTypeInformation
    Write-Host "Permissions report exported to $ExportDirectory" -ForegroundColor Green
}

# Call the function
Get-FolderPermissionsReport
