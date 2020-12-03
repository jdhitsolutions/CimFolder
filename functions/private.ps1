
#region class definitions

#the classes have no methods and use the default constructor
Class cimFolder {
    [string]$FullName
    [string]$Name
    [bool]$Archive
    [bool]$Compressed
    [DateTime]$CreationDate
    [string]$Computername
    [string]$Drive
    [bool]$Encrypted
    [bool]$Hidden
    [DateTime]$LastAccessed
    [DateTime]$LastModified
    [string]$Path
    [bool]$Readable
    [bool]$System
    [bool]$Writeable
    [string]$Mode
} #cimFolder class

Class cimFile {
    [string]$FullName
    [string]$Name
    [bool]$Archive
    [bool]$Compressed
    [DateTime]$CreationDate
    [string]$Computername
    [string]$Drive
    [bool]$Encrypted
    [bool]$Hidden
    [int64]$FileSize
    [DateTime]$LastAccessed
    [DateTime]$LastModified
    [string]$Path
    [bool]$Readable
    [bool]$System
    [bool]$Writeable
    [string]$Mode
} #cimFile class

#endregion

#region helper functions to create the new object types.

Function Get-Mode {
    [cmdletbinding()]
    param([object]$CimObject)

    # use the ternary operator to simplify the code,
    # although this will require PowerShell 7.x
    $dir = $CimObject.CimClass.Cimclassname -match 'Directory' ? "d" : "-"
    $archive = $CimObject.archive ? "a" : "-"
    $ro = $CimObject.writeable ? "-" : "r"
    $system = $CimObject.System ? "s" : "-"
    $hidden = $CimObject.Hidden ? "h" : "-"

    "{0}{1}{2}{3}{4}" -f $Dir, $Archive, $RO, $Hidden, $System
} #Get-Mode
Function New-CimFile {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [object]$CimObject
    )
    Begin {
        $properties = [CimFile].DeclaredProperties.Name
    }
    Process {
        $file = [CimFile]::New()
        foreach ($item in $properties) {
            $file.$item = $CimObject.$item
        }

        $file.name = Split-Path -Path $CimObject.caption -Leaf
        $file.fullname = $CimObject.Caption
        $file.computername = $CimObject.CSName
        $file.mode = Get-Mode $CimObject

        $file
    }
    End {
        #not used
    }
} #New-CimFile
Function New-CimFolder {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [object]$CimObject
    )
    Begin {
        $properties = [CimFolder].DeclaredProperties.Name
    }
    Process {
        $folder = [CimFolder]::New()
        foreach ($item in $properties) {
            $folder.$item = $CimObject.$item
        }

        $folder.name = Split-Path -Path $CimObject.caption -Leaf
        $folder.fullname = $CimObject.Caption
        $folder.computername = $CimObject.CSName
        $folder.mode = Get-Mode $CimObject

        $folder
    }
    End {
        #not used
    }
} #New-CimFolder

#endregion