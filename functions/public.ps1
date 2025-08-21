Function Get-CimFolder {
    [CmdletBinding(DefaultParameterSetName = 'computer')]
    [alias('cdir')]
    [OutputType('cimFolder', 'cimFile')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the folder path. Don't include the trailing \. If using a remote computer or CimSession, the path is relative to the remote system."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Path,
        [Parameter(Position = 1, HelpMessage = 'Specify the type of item to return. Default is All')]
        [ValidateSet('All', 'File', 'Folder')]
        [string]$ItemType = 'All',
        [Switch]$Recurse,
        [Parameter(HelpMessage = "Show hidden folders and files.")]
        [switch]$Force,
        [Parameter(ParameterSetName = 'computer')]
        [ValidateNotNullOrEmpty()]
        [alias('cn')]
        [String]$Computername = $env:COMPUTERNAME,
        [Parameter(ParameterSetName = 'session')]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimSession]$CimSession
    )
    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
        $CimParams = @{
            ClassName  = 'Win32_Directory'
            Filter     = ''
            CimSession = ''
            Verbose    = $False
        }
        if ($Force) {
            $folderFilter = {(Split-Path $_.name) -eq $main.name }
            $fileFilter ={ $_ }
        }
        else {
            $fileFilter = {-Not $_.Hidden}
            $folderFilter = {(-Not $_.Hidden) -AND (Split-Path $_.name) -eq $main.name }
        }
    } #begin

    Process {
        Write-Verbose "Detected parameter set $($PSCmdlet.ParameterSetName)"
        Write-Debug 'Using PSBoundParameters:'
        $PSBoundParameters | Out-String | Write-Debug
        if ($path -match '\\$') {
            Write-Verbose 'Stripping off a trailing slash'
            $path = $path -replace '\\$', ''
            Write-Verbose "Path is now $Path"
        }

        #if running locally, convert the path
        if (($Computername -eq $env:COMPUTERNAME) -AND ($PSCmdlet.ParameterSetName -eq 'Computer')) {
            Write-Verbose "Testing local path $path"
            Try {
                #convert Path to a file system path
                $cPath = (Convert-Path -Path $path -ErrorAction Stop) -replace '\\$', ''
                Write-Verbose "Using filesystem path $cPath"
            }
            Catch {
                Write-Warning "Can't validate the path $path. $($_.Exception.Message)"
                #bail out
                return
            }
        } #if localhost
        else {
            $cPath = [System.IO.Path]::GetFullPath($path)
            Write-Verbose "Using remote path $cPath"
        }
        #escape any \ in the path
        $rPath = $cPath.replace('\', '\\')
        $CimParams.Filter = "Name='$rPath'"

        Write-Verbose "Using query 'Select * from $($cimParams.ClassName) where $($CimParams.filter)'"
        if ($PSCmdlet.ParameterSetName -eq 'computer') {
            Try {
                $CimSession = New-CimSession -ComputerName $computername -ErrorAction Stop
                $tmpSession = $True
            }
            Catch {
                Throw $_
            }
        }
        Else {
            Write-Verbose "Using an existing CimSession to $($CimSession.computername)"
            $tmpSession = $False
        }
        $CimParams.CimSession = $CimSession

        Write-Verbose "Getting $cPath on $($CimSession.computername)"

        $main = Get-CimInstance @CimParams

        if ($main.name) {
            #filter out the parent folder

            if ($itemType -match 'Folder') {
                Write-Verbose 'Creating new CimFolder objects'
                $main | Get-CimAssociatedInstance -ResultClassName Win32_Directory -Verbose:$False |
                Where-Object $folderFilter | New-CimFolder | Tee-Object -Variable private:cf
                if ($private:cf.count -gt 0 -AND $Recurse) {
                    Write-Verbose 'Recursing...'
                    foreach ($fldr in $private:cf) {
                        Write-Verbose "... $($fldr.FullName)"
                        Get-CimFolder -path $fldr.FullName -CimSession $CimSession -recurse -ItemType $ItemType -force:$Force
                    }
                }
            }

            If ($itemType -match 'All|File') {
                Write-Verbose 'Creating new CimFile objects'
                #Still need folder objects for recursion
                #using a private variable to avoid scoping problems when recursing. Jan 8, 2021 JDH (Issue #1)
                $private:cf = $main | Get-CimAssociatedInstance -ResultClassName Win32_Directory -Verbose:$False |
                Where-Object $FolderFilter | New-CimFolder
                if ($itemType -match 'All') {
                    $private:cf
                }

                $main | Get-CimAssociatedInstance -ResultClassName CIM_DATAFile -Verbose:$False |
                Where-Object $fileFilter | New-CimFile

                if ($private:cf.count -gt 0 -AND $Recurse) {
                    Write-Verbose 'Recursing...'
                    foreach ($fldr in $private:cf) {
                        Write-Verbose "... $($fldr.FullName)"
                        Get-CimFolder -path $fldr.FullName -CimSession $CimSession -recurse -ItemType $ItemType -Force:$force
                    }
                }
            }
        }
        else {
            Write-Warning "Failed to find $cPath on $($CimSession.computername.ToUpper())"
        }
        if ($CimSession -AND $tmpSession) {
            Write-Verbose 'Remove the temporary session'
            Remove-CimSession $CimSession
        }
    } #Process
    End {
        Write-Verbose "Ending $($MyInvocation.MyCommand)"
    }
}
