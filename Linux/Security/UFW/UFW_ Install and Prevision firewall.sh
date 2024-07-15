#!/bin/sh

#This script is to setup UFW with SSH, HTTP, HTTPS, and SMB ports open

#check if UFW is installed, if not install it

if [ ! -f /usr/sbin/ufw ]; then
  apt-get install ufw -y

else
  echo "UFW is already installed"
fi

#enable UFW if not enabled

if ufw status | grep -q "inactive"; then
  ufw enable
  echo "UFW is now enabled"
else
  echo "UFW is already enabled"
fi

#allow SSH, HTTP, HTTPS, and SMB ports
ports="ssh http https 445 21 53"

for port in $ports; do
  if ufw status | grep -q $port; then
    echo "$port is already allowed"
  else
    ufw allow $port
    echo "$port is now allowed"
  fi
done