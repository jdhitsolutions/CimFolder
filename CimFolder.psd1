#
# Module manifest for CimFolder
#

@{
    RootModule           = 'CimFolder.psm1'
    ModuleVersion        = '1.0.0'
    CompatiblePSEditions = @('Core')
    GUID                 = '4a959e28-16d5-49a0-8115-392321cc1a9a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2020-2024 JDH Information Technology Solutions, Inc.'
    Description          = 'Get files and folders using CIM and PowerShell.'
    PowerShellVersion    = '7.4'
    TypesToProcess       = @()
    FormatsToProcess     = @('formats\cimfilefolder.format.ps1xml')
    FunctionsToExport    = 'Get-CimFolder'
    CmdletsToExport      = ''
    VariablesToExport    = ''
    AliasesToExport      = 'cdir'
    PrivateData          = @{
        PSData = @{
            Tags       = @('Cim', 'FileSystem')
            LicenseUri = 'https://github.com/jdhitsolutions/CimFolder/blob/main/LICENSE.txt'
            ProjectUri = 'https://github.com/jdhitsolutions/CimFolder/'
            IconUri    = ''
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}
