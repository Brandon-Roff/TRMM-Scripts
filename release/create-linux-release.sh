#!/usr/bin/env bash
# create-linux-release.sh
# Packages Linux scripts into TRMM-Linux-Scripts.zip and generates ReleaseNotes-Linux.md
# Requirements: git, bash, zip
# Usage: ./create-linux-release.sh [-p PREVIOUS_TAG] [-o OUTPUT_DIR]
set -euo pipefail
PREVIOUS_TAG=""
OUTPUT_DIR="$(pwd)/release"
while getopts ":p:o:" opt; do
  case $opt in
    p) PREVIOUS_TAG="$OPTARG";;
    o) OUTPUT_DIR="$OPTARG";;
    :) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
  esac
done

mkdir -p "$OUTPUT_DIR"
ARCHIVE_NAME="TRMM-Linux-Scripts.zip"
ARCHIVE_PATH="$OUTPUT_DIR/$ARCHIVE_NAME"
[ -f "$ARCHIVE_PATH" ] && rm -f "$ARCHIVE_PATH"
LINUX_ROOT="$(pwd)/Linux"
[ -d "$LINUX_ROOT" ] || { echo "Linux folder not found"; exit 1; }

# Collect script files
mapfile -t SCRIPT_FILES < <(find "$LINUX_ROOT" -type f \( -name '*.sh' -o -name '*.bash' \))
if [ ${#SCRIPT_FILES[@]} -eq 0 ]; then echo "No Linux scripts found"; fi
zip -q "$ARCHIVE_PATH" "${SCRIPT_FILES[@]}"
echo "Created archive: $ARCHIVE_PATH"

# Determine previous tag if not supplied
if [ -z "$PREVIOUS_TAG" ]; then
  PREVIOUS_TAG=$(git tag --sort=-creatordate | head -n1 || true)
fi

RELEASE_NOTES_PATH="$OUTPUT_DIR/ReleaseNotes-Linux.md"
{
  echo "# Linux Scripts Release"
  echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Archive: $ARCHIVE_NAME"
  echo "Previous Tag: ${PREVIOUS_TAG:-none}"\n
  if [ -n "$PREVIOUS_TAG" ]; then
    echo "## Changes Since $PREVIOUS_TAG"
    DIFF_LINES=$(git diff --name-status "$PREVIOUS_TAG" HEAD | grep '^\([AMRDC]\)\s\+Linux/' || true)
    if [ -n "$DIFF_LINES" ]; then
      echo "| Status | File |"
      echo "|--------|------|"
      echo "$DIFF_LINES" | while read -r line; do
        STATUS=$(echo "$line" | awk '{print $1}')
        FILE=$(echo "$line" | awk '{print $2}')
        [ "$STATUS" = "R" ] && FILE=$(echo "$line" | awk '{print $3}')
        echo "| $STATUS | $FILE |"
      done
    else
      echo "No file changes in Linux folder since $PREVIOUS_TAG."
    fi
  else
    echo "No previous tag found; initial release notes."\n
  fi
  echo "## Category Summary"
  echo "| Folder | Script Count |"
  echo "|--------|--------------|"
  find "$LINUX_ROOT" -type f -name '*.sh' -printf '%h\n' | sed "s|$LINUX_ROOT/||" | awk 'NF' | sort | uniq -c | while read -r count folder; do
    echo "| $folder | $count |"
  done
  echo "\n## Included Scripts"
  echo "| Name | Relative Path | Size (KB) |"
  echo "|------|---------------|-----------|"
  for f in "${SCRIPT_FILES[@]}"; do
    NAME=$(basename "$f")
    REL=$(echo "$f" | sed "s|$(pwd)/||")
    SIZE=$(du -k "$f" | awk '{print $1}')
    echo "| $NAME | $REL | $SIZE |"
  done
} > "$RELEASE_NOTES_PATH"

echo "Release notes generated: $RELEASE_NOTES_PATH"
echo "Done."
exit 0