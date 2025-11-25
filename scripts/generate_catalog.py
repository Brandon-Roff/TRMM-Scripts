import os
import sys
from pathlib import Path

REPO_URL = "https://github.com/Brandon-Roff/TRMM-Scripts.git"
CLONE_DIR = Path("tmp_trmm_repo")

def run(cmd):
    return os.system(cmd)

def clone_repo():
    if CLONE_DIR.exists():
        return
    ret = run(f"git clone --depth=1 {REPO_URL} {CLONE_DIR}")
    if ret != 0:
        print("git clone failed")
        sys.exit(1)

def gather_files():
    files = []
    for p in CLONE_DIR.rglob('*'):
        if p.is_file():
            rel = p.relative_to(CLONE_DIR)
            files.append(rel.as_posix())
    return sorted(files)

def infer_category(path):
    parts = Path(path).parts
    if len(parts) >= 2:
        return parts[0]
    return "root"

def generate_catalog(files, out_path):
    lines = ["# Script Catalog", "", "This catalog is auto-generated from repository filenames.", ""]
    lines.append("| Path | File | Category |")
    lines.append("|---|---|---|")
    for f in files:
        name = os.path.basename(f)
        cat = infer_category(f)
        lines.append(f"| {f} | {name} | {cat} |")
    content = "\n".join(lines)
    out_path.write_text(content, encoding="utf-8")
    print(f"Wrote {out_path}")

def main():
    docs_dir = Path("docs")
    if not docs_dir.exists():
        print("docs/ directory missing")
        sys.exit(1)
    clone_repo()
    files = gather_files()
    out = docs_dir / "catalog.md"
    generate_catalog(files, out)

if __name__ == '__main__':
    main()
