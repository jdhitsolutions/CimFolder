# CimFolder

<p align="left"><img align="left" src = "images/folder.png"></p>

This module uses CIM classes to retrieve files and directories from the local computer or a remote computer by name or using a CIMSession. It only has a single command, `Get-CimFolder` with an alias of `cdir`. The module includes [help documentation](docs/Get-CimFolder.md) for the command. The module includes a [custom formatting file](formats/cimfilefolder.format.ps1xml) with several defined views.

This module is a sample solution for an [Iron Scripter challenge](https://ironscripter.us/a-cim-ple-powershell-challenge/) and should be considered a work in progress or proof-of-concept. This __is not__ the only, or definitive solution to the challenge.

The module will only work on PowerShell 7.x on Windows platforms, although it could be rewritten to work in Windows PowerShell. There's no particular reason, other than I wanted an excuse to use the ternary operators and I find it easier to work with ANSI escape sequences in PowerShell 7 instead of Windows PowerShell.

For background information on how I developed this module, take a look at [https://jdhitsolutions.com/blog/powershell/7992/answering-the-cim-directory-challenge/](https://jdhitsolutions.com/blog/powershell/7992/answering-the-cim-directory-challenge/).

## Sample Usage

Here are a few examples of the module in action.

|![Get-CimFolder](images/get-cimfolder.png)|
|:--:|
|_Get a folder listing with colored highlights_|

The current version of the command lacks filtering capabilities. But the module includes an additional custom table view.

|![Age view](images/ageview.png)|
|:--:|
|_Using a custom view_|

You can query a remote computer by its name, or create a CIM Session.

|![cimsession](images/cimsession.png)|
|:--:|
|_Using a CIMSession_|

As an interesting side note, using the CIM cmdlets appear to circumvent access-control. At least, enough to get a listing.

|![access override](images/access.png)|
|:--:|
|_Avoiding Access Denied_|

Using the CIM cmdlets is most likely going to be slower than traditional commands. There is always overhead when using the CIM cmdlets. There is always a trade-off between raw performance and ease-of-use.

### A Note on Recursion

When I first published this module and wrote about it, I thought there was a potential issue where some files and folders couldn't be queried with the CIM cmdlets. After looking at my code a bit more, I realized the issue was a bug in how I was handling recursion. Version 0.5.0 of this module includes an updated function which now appears to list all files and folders.

## Next Steps

The module has room for improvement if you'd like a challenge.

+ Add parameter validation to ensure Path is a FileSystem path or at least looks like one.get
+ Add parameters to display only directories or files.
+ Don't display hidden files and folders by default.
+ Add a `-Force` parameter to display hidden files and folders.
+ Add a color display for 0-byte files.
+ Add a color display based file extension.
+ Add filtering options for file names.
+ Add better error handling if the path on the remote computer doesn't exist.
+ Add an `-Asjob` parameter to run as a background job.
+ Improve performance for a large number of subfolders by using `Foreach-Object -parallel`.

There are no plans to publish this module to the PowerShell Gallery as it is not a production-ready tool and performs poorly on large directories compared to traditional commands.

last updated _2021-01-08 18:55:12ZZ_
