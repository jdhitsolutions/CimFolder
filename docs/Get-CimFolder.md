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
Get-CimFolder [[-Path] <String>] [-Recurse] [-Computername <String>] [<CommonParameters>]
```

### session

```yaml
Get-CimFolder [[-Path] <String>] [-Recurse] [-CimSession <CimSession>] [<CommonParameters>]
```

## DESCRIPTION

This command uses CIM to list files and folders. You can query a local or remote computer using CIM and a WSMAN connection. Be aware that not every file and folder is completely registered. You may run the command on a folder and not see every file or folder.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-CimFolder c:\work

   Path: [WIN10] c:\work\

Mode               LastModified           Size Name
----               ------------           ---- ----
d----      12/2/2020 4:35:03 PM                data
d----     12/1/2020 12:30:56 PM                demo
d----     12/23/2020 9:13:37 AM                rmhpstools
d----      12/1/2020 2:58:22 PM                samples
-a---     12/1/2020 11:30:55 AM              0 a.csv
-a---     12/1/2020 12:40:03 PM              0 a.md
-a---     12/31/2020 9:10:15 AM          14346 a.txt
-a---    12/31/2020 12:15:44 PM         171394 a.xml
-a---     12/31/2020 9:13:16 AM          28866 aa.ps1
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

Enter the folder path. Don't include the trailing \. This path is relative to the computer or CIMSession.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### cimFolder

### cimFile

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-ChildItem]()
