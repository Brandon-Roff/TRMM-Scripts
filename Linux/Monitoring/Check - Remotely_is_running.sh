# This Script will check if Remotley Agent is Running on system will code 2 if its being started code 1 if it cant#fails and 0 on success of process

RemotelyService = "remotely-agent.service"

#Check if Remotely Agent is Running and start it if not

echo "Checking if Remotely Agent is Running..."
echo ""

if [ $(systemctl is-active $RemotelyService) = "active" ]; then
    echo "Remotely Agent is Running"
    exit 0
else
    echo "Remotely Agent is not Running"
    systemctl start $RemotelyService
    if [ $(systemctl is-active $RemotelyService) = "active" ]; then
        echo "Remotely Agent has been started"
        exit 2
    else
        echo "Remotely Agent could not be started"
        exit 1
    fi
fi

