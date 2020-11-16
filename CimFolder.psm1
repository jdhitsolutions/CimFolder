
. $PSScriptRoot\functions\private.ps1
. $PSScriptRoot\functions\public.ps1

Update-TypeData -TypeName cimFolder -DefaultDisplayPropertySet Mode, LastModified, Size, Name -Force
Update-TypeData -TypeName cimFile -MemberType AliasProperty -MemberName Size -Value FileSize -Force
Update-TypeData -TypeName cimFile -DefaultDisplayPropertySet Mode, LastModified, Size, Name -Force