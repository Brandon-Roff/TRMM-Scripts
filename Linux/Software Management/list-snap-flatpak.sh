#!/bin/bash
# List all installed Snap and Flatpak packages
if command -v snap &> /dev/null; then
  echo "Snap packages:"
  snap list
else
  echo "Snap is not installed."
fi

echo
if command -v flatpak &> /dev/null; then
  echo "Flatpak packages:"
  flatpak list
else
  echo "Flatpak is not installed."
fi
