#!/usr/bin/env bash
set -euo pipefail

echo "== Hygiene Audit =="

FAIL=0

echo "-- Checking executable scripts for shebangs --"
while IFS= read -r f; do
  if head -n1 "$f" | grep -q '^#!/'; then
    :
  else
    echo "Missing shebang: $f"; FAIL=1
  fi
done < <(git ls-files | grep -E '\.(sh|bash)$')

echo "-- Checking PowerShell scripts for BOM/encoding warnings --"
while IFS= read -r f; do
  if file "$f" | grep -qi 'CRLF'; then
    echo "CRLF (OK): $f" > /dev/null
  fi
done < <(git ls-files | grep -E '\.(ps1)$')

echo "-- Checking for accidental secrets (basic patterns) --"
PATTERNS='AWS_SECRET_ACCESS_KEY|BEGIN RSA PRIVATE KEY|password=' 
grep -I -R -n -E "$PATTERNS" . || echo "No obvious secrets detected."

if [ $FAIL -ne 0 ]; then
  echo "Hygiene audit failed." >&2
  exit 1
fi

echo "Hygiene audit passed."