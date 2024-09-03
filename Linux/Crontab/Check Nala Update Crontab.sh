# This Script will check if the nala update is in crontab and will add it if it is not

#I choose to have it run every sunday at 2am

#Check if nala is installed

if [ -f /usr/local/bin/nala ]; then
    echo "Nala is installed"
else
    echo "Nala is not installed"
    exit 1
fi

#Check if nala update command is in crontab

if crontab -l | grep -q "nala upgrade -y"; then
    echo "Nala update is in crontab"
    exit 0
else
    echo "Nala update is not in crontab"
    echo "Adding Nala update to crontab"
    (crontab -l ; echo "0 2 * * 0 /usr/local/bin/nala upgrade -y") | crontab -
    exit 2
fi


