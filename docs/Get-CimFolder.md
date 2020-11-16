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

This command uses CIM to list files and folders.

## EXAMPLES

### Example 1

```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -CimSession

{{ Fill CimSession Description }}

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

{{ Fill Computername Description }}

```yaml
Type: String
Parameter Sets: computer
Aliases: cn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Enter the folder path.
Don't include the trailing \.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse

{{ Fill Recurse Description }}

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
