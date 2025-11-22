#!/usr/bin/env bash
# Customize - Global Bashrc (from Custom_ Bashrc.sh)
BACKUP_DIR="/etc/bash_backup"; mkdir -p "$BACKUP_DIR"
GLOBAL="/etc/bash.bashrc"; [ -f "$GLOBAL" ] && cp "$GLOBAL" "$BACKUP_DIR/bash.bashrc_$(date +%Y%m%d_%H%M%S)"
cat <<'EOF' > "$GLOBAL"
# Customized bashrc (shortened placeholder). Add aliases/functions as required.
[ -z "$PS1" ] && return
alias ll='ls -alF'
EOF
echo "Global bashrc customized."; exit 0