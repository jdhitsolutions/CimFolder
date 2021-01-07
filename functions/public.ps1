Function Get-CimFolder {
    [cmdletbinding(DefaultParameterSetName = "computer")]
    [alias("cdir")]
    [OutputType("cimFolder", "cimFile")]
    Param(
        [Parameter(Position = 0, Mandatory,HelpMessage = "Enter the folder path. Don't include the trailing \. If using a remote computer or CIMSession, the path is relative to the remote system.")]
        [ValidateNotNullorEmpty()]
        [string]$Path,
        [switch]$Recurse,
        [Parameter(ParameterSetName = "computer")]
        [ValidateNotNullOrEmpty()]
        [alias("cn")]
        [string]$Computername = $env:COMPUTERNAME,
        [Parameter(ParameterSetName = "session")]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimSession]$CimSession
    )
    Begin {
        Write-Verbose "Starting $($myinvocation.MyCommand)"
        $cimParams = @{
            Classname  = "win32_directory"
            Filter     = ""
            CimSession = ""
        }
    } #begin

    Process {
        Write-Verbose "Detected parameter set $($pscmdlet.ParameterSetName)"
        #convert Path to a file system path

        if ($path -match '\\$') {
            Write-Verbose "Stripping off a trailing slash"
            $path = $path -replace "\\$", ""
            Write-Verbose "Path is now $Path"
        }

        #if running locally, convert the path
        if (($Computername -eq $env:COMPUTERNAME) -AND ($pscmdlet.ParameterSetName -eq 'Computer')) {
            Write-Verbose "Testing local path $path"
            Try {
                $cpath = Convert-Path -Path $path -ErrorAction Stop
            }
            Catch {
                Write-Warning "Can't validate the path $path. $($_.Exception.Message)"
                #bail out
                return
            }
        } #if localhost
        else {
            Write-Verbose "Using remote path $path"
            $cPath =  [System.IO.Path]::GetFullPath($path)
        }
        #escape any \ in the path
        $rPath = $cpath.replace("\", "\\")
        $cimParams.Filter = "Name='$rpath'"

        Write-Verbose "Using query $($cimparams.filter)"
        if ($pscmdlet.ParameterSetName -eq 'computer') {
            Try {
                $cimSession = New-CimSession -ComputerName $computername -ErrorAction Stop
                $tmpSession = $True
            }
            Catch {
                Throw $_
            }
        }
        Else {
            Write-Verbose "Using an existing CIMSession to $($cimsession.computername)"
            $tmpSession = $False
        }
        $cimParams.Cimsession = $CimSession

        Write-Verbose "Getting $cpath on $($cimsession.computername)"

        $main = Get-CimInstance @cimParams

        #filter out the parent folder
        Write-Verbose "Creating new CimFolder objects"
        $main | Get-CimAssociatedInstance -ResultClassName Win32_Directory |
        Where-Object { (Split-Path $_.name) -eq $main.name } | New-CimFolder -outvariable cf

        Write-Verbose "Creating new CimFile objects"
        $main | Get-CimAssociatedInstance -ResultClassName CIM_DATAFile | New-Cimfile

        if ($cf -AND $recurse) {
            Write-Verbose "Recursing..."
            foreach ($fldr in $cf.fullname) {
                Write-Verbose "Processing sub-folder $fldr"
                Get-CimFolder -path $Fldr -CimSession $cimSession
            }
        }

        if ($cimSession -AND $tmpSession) {
            Write-Verbose "Remove the temporary session"
            Remove-CimSession $cimSession
        }
    } #Process
    End {
        Write-Verbose "Ending $($myinvocation.MyCommand)"
    }
}
