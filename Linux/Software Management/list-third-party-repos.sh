#!/bin/bash
# List all non-default repositories and PPAs
if [ -f /etc/apt/sources.list ]; then
  grep -v '^#' /etc/apt/sources.list | grep -v 'main restricted universe multiverse' | grep -v '^$'
fi
if [ -d /etc/apt/sources.list.d ]; then
  echo "\nThird-party sources in /etc/apt/sources.list.d/:"
  grep -h -v '^#' /etc/apt/sources.list.d/*.list | grep -v '^$'
fi
