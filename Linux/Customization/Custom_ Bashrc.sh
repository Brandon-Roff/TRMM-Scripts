#!/bin/bash

# Backup directory
BACKUP_DIR="/etc/bash_backup"

# Create the backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Backup the existing global .bashrc file with a timestamp
GLOBAL_BASHRC="/etc/bash.bashrc"
if [ -f "$GLOBAL_BASHRC" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    cp "$GLOBAL_BASHRC" "$BACKUP_DIR/bash.bashrc_$TIMESTAMP"
    echo "Backup of global .bashrc completed: $BACKUP_DIR/bash.bashrc_$TIMESTAMP"
else
    echo "No existing global .bashrc file found to back up."
fi

# Write the new global .bashrc content to the global .bashrc file
cat << 'EOF' > "$GLOBAL_BASHRC"
# /etc/bash.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Custom prompt (includes Git branch if applicable)
parse_git_branch() {
  git branch 2>/dev/null | grep -e '\*' | sed 's/^..\(.*\)/ (\1)/'
}

# A more stylish prompt with different colors
PS1='\[\e[0;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[0;31m\]$(parse_git_branch)\[\e[0;33m\]\$\[\e[m\] '

# Enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# -------------------------------
# Command Enhancements & Aliases
# -------------------------------

# Add color to common commands
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

# File management
alias mkdir='mkdir -p'
alias rmf='rm -rf'
alias cpv='cp -v'
alias mvv='mv -v'

# Disk usage and space
alias df='df -h'
alias du='du -h'
alias dus='du -sh * | sort -h'

# -------------------------------
# Network & IP Aliases
# -------------------------------

alias myip='curl http://ipecho.net/plain; echo'
alias pingg='ping google.com'

# -------------------------------
# System Monitoring & Updates
# -------------------------------

alias top='htop'
alias meminfo='free -m -l -t'
alias ports='netstat -tulanp'
alias update='sudo nala upgrade -y && sudo nala autoremove -y'

# -------------------------------
# Git Aliases
# -------------------------------

alias gst='git status'
alias gcm='git commit -m'
alias gp='git push'
alias gco='git checkout'
alias glog='git log --oneline --graph --decorate'

# -------------------------------
# Docker/Portainer Shortcuts
# -------------------------------

alias dps='docker ps'
alias di='docker images'
alias drm='docker rm $(docker ps -a -q)'
alias dclean='docker system prune -a --volumes'
alias dstopall='docker stop $(docker ps -q)'

# -------------------------------
# Python Shortcuts
# -------------------------------

alias py='python3'
alias pipi='pip install'

# -------------------------------
# Navigation Shortcuts
# -------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias home='cd ~'
alias work='cd ~/work'
alias projects='cd ~/projects'

# -------------------------------
# DNS & IP Tools
# -------------------------------

alias flushdns='sudo systemd-resolve --flush-caches'
alias dig='dig +nocmd +noall +answer'
alias nslookup='nslookup'

# -------------------------------
# Miscellaneous Functions & Aliases
# -------------------------------

# Extract function for compressed files
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xvf "$1"   ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;

        esac
    else
        echo "'$1' is not a valid file"
    fi
}
alias extract="extract"

# Aliases for safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Function to show last N commands
hist() {
    history | tail -n "$1"
}

# Alias to display all aliases
alias aliaslist='alias -p'

# Reload bashrc
alias reload='source ~/.bashrc'

# Enable command auto-correction
shopt -s cdspell
shopt -s dirspell
shopt -s checkwinsize

# Add custom PATH
export PATH=$PATH:$HOME/bin
EOF

echo "Global .bashrc has been updated with the new content."

# Note: Each user will need to log in again or source their .bashrc to see changes