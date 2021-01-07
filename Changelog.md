# Changelog for CimFolder

## v0.4.0

+ Fixed a bug in `Get-CimFolder` that was failing to enumerate a drive path like C:\ or D:\.
+ Help updates.
+ Updated `README.md`.

## v0.3.0

+ Added external help.
+ Made `Path` parameter in `Get-CimFolder` mandatory and with no default.
+ Fixed path validation bugs that were failing when querying a remote computer.
+ Added computer name to default table format.
+ Modified `Age` formatted view to highlight old and young files in color.

## v0.2.0

+ Added a new type extension to `cimFile` called `ModifiedAge`.
+ Added a new view called `Age` to use the `ModifiedAge` property.
+ Re-ordered ANSI formatting.
+ Updated `README.md`.

## v0.1.0

+ Initial files
