# Changelog for CimFolder

## [Unreleased]

## [1.0.0] - 2025-08-21

### Added

- Added `-Force` parameter to include hidden files and folders. The new default behavior is NOT to show hidden files and folders.
- Added a warning message if the path was not found on a remote computer.
- Updated formatting to highlight for 0-byte files in red.
- Added parameter to `Get-CimFolder` to return only files or folders. The default is All items.

### Changed

- Updated `README`.
- Code cleanup
- Updated Changelog to new format

### Fixed

- Revised `Get-CimFolder` to convert PSDrive references to correct file system paths.

## [v0.5.0] - 2021-01-08

- Fixed recursion bug in `Get-CimFolder`. [Issue #1](https://github.com/jdhitsolutions/CimFolder/issues/1)

## [v0.4.0] - 2021-01-07

- Fixed a bug in `Get-CimFolder` that was failing to enumerate a drive path like C:\ or D:\.
- Help updates.
- Updated `README.md`.

## [v0.3.0] - 2021-01-07

- Added external help.
- Made `Path` parameter in `Get-CimFolder` mandatory and with no default.
- Fixed path validation bugs that were failing when querying a remote computer.
- Added computer name to default table format.
- Modified `Age` formatted view to highlight old and young files in color.

## v0.2.0 - 2020-12-03

- Added a new type extension to `cimFile` called `ModifiedAge`.
- Added a new view called `Age` to use the `ModifiedAge` property.
- Re-ordered ANSI formatting.
- Updated `README.md`.

## v0.1.0 - 2020-11-16

- Initial files

[Unreleased]: https://github.com/jdhitsolutions/CimFolder/compare/v1.0.0..HEAD
[1.0.0]: https://github.com/jdhitsolutions/CimFolder/compare/vv0.5.0..v1.0.0
[v0.5.0]: https://github.com/jdhitsolutions/CimFolder/compare/v0.4.0..v0.5.0
[v0.4.0]: https://github.com/jdhitsolutions/CimFolder/compare/v0.3.0..v0.4.0