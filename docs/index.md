<div style="display:flex;align-items:center;gap:16px;margin-bottom:18px">
  <img src="assets/logo.svg" alt="logo" width="72" height="72" style="border-radius:12px;background:#200000;padding:8px"/>
  <div>
    <h1 style="margin:0;color:#ff4d4d">TRMM Scripts Documentation</h1>
    <p style="margin:4px 0 0;color:#bbb">A curated collection of automation scripts for Tactical RMM. Red & black theme.</p>
  </div>
</div>

## Quick links

- [Windows Scripts](windows/index.md)
- [Linux Scripts](linux/index.md)
- [Script Catalog](catalog.md)
- [Naming Convention](naming-convention.md)

## Featured

### 🔥 Recent release
Check the repository Releases for the latest packaged script archives.

### 🧩 How the catalog is generated
Run the included generator script `scripts/generate_catalog.py` locally or let GitHub Actions run it to produce `docs/catalog.md` from repository filenames.

## Getting started

```bash
git clone https://github.com/Brandon-Roff/TRMM-Scripts.git
pip install mkdocs mkdocs-material pymdown-extensions
mkdocs serve
```
