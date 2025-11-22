#!/usr/bin/env bash
# Software Management - Nala Install Status (from Nala Install Status.sh)
if command -v nala >/dev/null 2>&1; then echo "Nala installed"; exit 0; else echo "Installing Nala"; apt-get install -y nala >/dev/null 2>&1; if command -v nala >/dev/null 2>&1; then echo "Nala installed (post-install)"; exit 66; else echo "Nala install failed"; exit 1; fi; fi