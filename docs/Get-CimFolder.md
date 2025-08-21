---
external help file: CimFolder-help.xml
Module Name: CimFolder
online version:
schema: 2.0.0
---

# Get-CimFolder

## SYNOPSIS

Get files and folders using CIM.

## SYNTAX

### computer (Default)

```yaml
Get-CimFolder [-Path] <String> [-ItemType <String>] [-Recurse] [-Force] [-Computername <String>]
[<CommonParameters>]
```

### session

```yaml
Get-CimFolder [-Path] <String> [-ItemType <String>] [-Recurse] [-Force] [-CimSession <CimSession>] [<CommonParameters>]
```

## DESCRIPTION

This command uses CIM to list files and folders. You can query a local or remote computer using CIM and a WSMAN connection. Be aware that not every file and folder is completely registered. You may run the command on a folder and not see every file or folder.

This command is a proof-of-concept and is not optimized for production use, especially when using on large folders.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-CimFolder c:\work

   Path: [WIN10] c:\work\

Mode               LastModified           Size Name
----               ------------           ---- ----
d----      12/2/2024 4:35:03 PM                data
d----     12/1/2024 12:30:56 PM                demo
d----     12/23/2024 9:13:37 AM                jdhpstools
d----      12/1/2024 2:58:22 PM                samples
-a---     12/1/2024 11:30:55 AM              0 a.csv
-a---     12/1/2024 12:40:03 PM              0 a.md
-a---     12/31/2024 9:10:15 AM          14346 a.txt
-a---    12/31/2024 12:15:44 PM         171394 a.xml
-a---     12/31/2024 9:13:16 AM          28866 aa.ps1
...
```

Folders and some files will be displayed in color.

### Example 2

```powershell
PS C:\> Get-CimFolder -path c:\drivers -computername ThinkP1

   Path: [THINKP1] c:\drivers\

Mode               LastModified           Size Name
----               ------------           ---- ----
d----      2/20/2019 5:53:23 PM                WIN
```

### Example 3

```powershell
Get-CimFolder -Path C:\temp\ -ItemType Folder

   Path: [PROSPERO] c:\temp\

Mode               LastModified           Size Name
----               ------------           ---- ----
d----       5/8/2025 3:01:22 PM                data
d----      6/17/2025 2:26:30 PM                en-US
d----       5/9/2025 9:52:22 AM                htmlAgilityPack
d----      6/13/2025 3:59:25 PM                PSBluesky
d----       6/2/2025 3:39:29 PM                repo.txt
d----      7/29/2025 5:06:33 PM                tools
d----       6/4/2025 8:57:31 AM                workflows
```

Get only folders in the C:\temp\ folder.

## PARAMETERS

### -CimSession

Use an existing CIMSession.

```yaml
Type: CimSession
Parameter Sets: session
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Computername

The name of a remote computer to connect to.

```yaml
Type: String
Parameter Sets: computer
Aliases: cn

Required: False
Position: Named
Default value: localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Enter the folder path. Don't include the trailing \ unless you are querying a drive root e.g. D:\. This path is relative to the computer or CIMSession.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Show hidden folders and files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemType

Specify the type of item to return. Default is All

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### cimFolder

### cimFile

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-ChildItem]()

[Get-CimInstance]()

[Get-CimAssociatedInstance]()
