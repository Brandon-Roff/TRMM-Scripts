KEEP=2  # Number of kernels to keep
LOG="/tmp/old_kernel_prune.log"
> "$LOG"

echo "=== Linux Old Kernel Pruner ===" | tee -a "$LOG"

# Detect package manager
if command -v apt &>/dev/null; then
    PM="apt"
elif command -v dnf &>/dev/null; then
    PM="dnf"
elif command -v yum &>/dev/null; then
    PM="yum"
elif command -v zypper &>/dev/null; then
    PM="zypper"
else
    echo "ERROR: Unsupported package manager." | tee -a "$LOG"
    exit 1
fi

# Get running kernel
CURRENT_KERNEL=$(uname -r)

echo "Current kernel: $CURRENT_KERNEL" | tee -a "$LOG"

case $PM in
    apt)
        ALL_KERNELS=$(dpkg --list | grep linux-image | awk '{print $2}' | grep -v "$CURRENT_KERNEL" | sort -V)
        ;;
    dnf|yum)
        ALL_KERNELS=$(rpm -q kernel | grep -v "$CURRENT_KERNEL" | sort -V)
        ;;
    zypper)
        ALL_KERNELS=$(zypper search -i kernel | grep "^i" | awk '{print $3}' | grep -v "$CURRENT_KERNEL" | sort -V)
        ;;
esac

TOTAL=$(echo "$ALL_KERNELS" | wc -l)
if [ "$TOTAL" -le "$KEEP" ]; then
    echo "No old kernels to remove." | tee -a "$LOG"
    exit 0
fi

REMOVE=$(echo "$ALL_KERNELS" | head -n -$KEEP)
echo "Removing old kernels:" | tee -a "$LOG"
echo "$REMOVE" | tee -a "$LOG"

case $PM in
    apt)
        sudo apt-get purge -y $REMOVE >> "$LOG" 2>&1
        ;;
    dnf)
        sudo dnf remove -y $REMOVE >> "$LOG" 2>&1
        ;;
    yum)
        sudo yum remove -y $REMOVE >> "$LOG" 2>&1
        ;;
    zypper)
        sudo zypper remove -y $REMOVE >> "$LOG" 2>&1
        ;;
esac

echo "Old kernels removed successfully." | tee -a "$LOG"
exit 0