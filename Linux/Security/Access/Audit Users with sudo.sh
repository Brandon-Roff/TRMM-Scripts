# This Script will check and ouput the users that sudo access to the system

# Check if the script is being run as root
if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Check all the users that have sudo access
echo "The following users have sudo access to the system"
echo ""

grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}'

echo ""
