#!/usr/bin/env bash
# Software Management - Third Party Repos List (from list-third-party-repos.sh)
[ -f /etc/apt/sources.list ] && grep -v '^#' /etc/apt/sources.list | grep -v '^$'
if [ -d /etc/apt/sources.list.d ]; then echo "\n/etc/apt/sources.list.d:"; grep -h -v '^#' /etc/apt/sources.list.d/*.list | grep -v '^$'; fi
exit 0