#!/usr/bin/env bash
# Checks all installed packages for available updates
# Exit codes: 0=up-to-date, 10=updates available, 20=errors

set -euo pipefail

EXIT_CODE=0
NOW="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
HOST="$(hostname -f 2>/dev/null || hostname)"

# Detect package manager
if command -v apt >/dev/null 2>&1; then
  PM="apt"
elif command -v dnf >/dev/null 2>&1; then
  PM="dnf"
elif command -v yum >/dev/null 2>&1; then
  PM="yum"
elif command -v zypper >/dev/null 2>&1; then
  PM="zypper"
else
  echo "[$NOW] ERROR: No supported package manager found." >&2
  exit 20
fi

log() {
  printf "[%s] %s\n" "$NOW" "$1"
}

log "Full System Patch-Check Report for $HOST"
log "--------------------------------------------------------"
printf "%-40s %-15s %-15s %-10s\n" "PACKAGE" "INSTALLED" "AVAILABLE" "STATUS"
printf "%-40s %-15s %-15s %-10s\n" "----------------------------------------" "---------------" "---------------" "----------"

case "$PM" in
  apt)
    apt update -qq >/dev/null
    mapfile -t updates < <(apt list --upgradable 2>/dev/null | tail -n +2)
    ;;
  dnf|yum)
    $PM check-update >/dev/null || true
    mapfile -t updates < <($PM list updates 2>/dev/null | awk 'NR>1 && $1 !~ /^Obsoleting/ {print}')
    ;;
  zypper)
    mapfile -t updates < <(zypper list-updates 2>/dev/null | tail -n +4)
    ;;
esac

if [[ ${#updates[@]} -eq 0 ]]; then
  log "No updates available."
  exit 0
fi

for line in "${updates[@]}"; do
  case "$PM" in
    apt)
      pkg=$(echo "$line" | cut -d/ -f1)
      available=$(echo "$line" | awk '{print $2}')
      installed=$(dpkg -s "$pkg" 2>/dev/null | awk '/^Version:/ {print $2}')
      ;;
    dnf|yum)
      pkg=$(echo "$line" | awk '{print $1}')
      available=$(echo "$line" | awk '{print $2}')
      installed=$($PM list installed "$pkg" 2>/dev/null | awk 'NR==2 {print $2}')
      ;;
    zypper)
      pkg=$(echo "$line" | awk '{print $2}')
      installed=$(echo "$line" | awk '{print $3}')
      available=$(echo "$line" | awk '{print $4}')
      ;;
  esac

  printf "%-40s %-15s %-15s %-10s\n" "$pkg" "$installed" "$available" "OUTDATED"
  EXIT_CODE=10
done

log "--------------------------------------------------------"
log "Total packages with updates: ${#updates[@]}"
exit $EXIT_CODE
