#!/usr/bin/env bash
# Check - Third Party Patch Status (from 3rd Party Patch Check.sh)
# Enumerate outdated third-party packages (deb-based placeholder)
if ! command -v apt >/dev/null 2>&1; then echo "Non-apt system: adapt logic"; exit 0; fi
UPDATES=$(apt list --upgradable 2>/dev/null | tail -n +2 | wc -l)
echo "Third-party packages with updates: $UPDATES"; [ "$UPDATES" -gt 0 ] && exit 10 || exit 0