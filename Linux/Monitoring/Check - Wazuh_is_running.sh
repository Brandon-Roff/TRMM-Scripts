#This Script will check if Wazuh is Running on system will code 2 if its being started code 1 if it cant#fails and 0 on success of process

WazuhAgentService = "wazuh-agent.service"

#Check if Wazuh Agent is Running and start it if not

echo "Checking if Wazuh Agent is Running..."
echo ""

if [ $(systemctl is-active $WazuhAgentService) = "active" ]; then
    echo "Wazuh Agent is Running"
    exit 0
else
    echo "Wazuh Agent is not Running"
    systemctl start $WazuhAgentService
    if [ $(systemctl is-active $WazuhAgentService) = "active" ]; then
        echo "Wazuh Agent has been started"
        exit 2
    else
        echo "Wazuh Agent could not be started"
        exit 1
    fi
fi

