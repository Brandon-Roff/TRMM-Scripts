# Release Packaging Scripts

This folder contains helper scripts to build distributable archives of the TacticalRMM scripts for Windows and Linux and generate *in-depth release notes* highlighting changes since the previous tagged release.

## Scripts
| Script | Platform | Purpose |
|--------|----------|---------|
| Create-Windows-Release.ps1 | Windows (PowerShell) | Produces `TRMM-Windows-Scripts.zip` and `ReleaseNotes-Windows.md`. |
| create-linux-release.sh | Linux (bash) | Produces `TRMM-Linux-Scripts.zip` and `ReleaseNotes-Linux.md`. |

## Features
- Automatic collection of all script files.
- Markdown release notes with:
  - Previous tag reference.
  - Change table (git name-status) scoped to the OS folder.
  - Category (folder) summaries.
  - Full script inventory table with sizes.
- Clean overwrite of prior archives.

## Usage
### Windows
```powershell
# From repo root
./release/Create-Windows-Release.ps1 -PreviousTag v1.2.0
# Or let the script pick the most recent tag
./release/Create-Windows-Release.ps1
```

### Linux
```bash
# From repo root (make executable first if needed)
chmod +x release/create-linux-release.sh
./release/create-linux-release.sh -p v1.2.0
# Or default most recent tag
./release/create-linux-release.sh
```

## Output
After running, the `release/` folder contains:
- `TRMM-Windows-Scripts.zip` / `TRMM-Linux-Scripts.zip`
- `ReleaseNotes-Windows.md` / `ReleaseNotes-Linux.md`

## Release Notes Depth
Each release notes file is designed to be more detailed than simple changelogs. It includes structural summaries and inventories so downstream consumers can quickly evaluate impact.

## Future Improvements
- Sign archives (code signing / checksum generation).
- Optional JSON manifest for programmatic consumption.
- Filtering by category prefix.

Contributions welcome!
