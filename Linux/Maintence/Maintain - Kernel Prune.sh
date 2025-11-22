#!/usr/bin/env bash
# Maintain - Kernel Prune (from Kernel Prune.sh)
KEEP=${KEEP:-2}
PM=""; command -v apt >/dev/null 2>&1 && PM=apt || command -v dnf >/dev/null 2>&1 && PM=dnf || command -v yum >/dev/null 2>&1 && PM=yum || command -v zypper >/dev/null 2>&1 && PM=zypper
[ -z "$PM" ] && echo "Unsupported package manager" && exit 1
CUR=$(uname -r)
case $PM in
  apt) ALL=$(dpkg --list | grep linux-image | awk '{print $2}' | grep -v "$CUR" | sort -V);;
  dnf|yum) ALL=$(rpm -q kernel | grep -v "$CUR" | sort -V);;
  zypper) ALL=$(zypper search -i kernel | grep '^i' | awk '{print $3}' | grep -v "$CUR" | sort -V);;
esac
TOTAL=$(echo "$ALL" | wc -l)
[ "$TOTAL" -le "$KEEP" ] && echo "No old kernels to remove" && exit 0
REMOVE=$(echo "$ALL" | head -n -$KEEP)
case $PM in
  apt) apt-get purge -y $REMOVE;;
  dnf) dnf remove -y $REMOVE;;
  yum) yum remove -y $REMOVE;;
  zypper) zypper remove -y $REMOVE;;
esac
echo "Old kernels pruned."; exit 0