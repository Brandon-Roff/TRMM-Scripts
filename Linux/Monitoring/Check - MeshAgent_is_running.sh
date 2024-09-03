# This Script will check to see if Meshagent is Running on a system and attempt to start it if not 

MeshagentService="meshagent.service"

# Check if Mesh agent is Running and Attemp to restart it if not

if [ $(systemctl is-active $MeshagentService) = "active" ]; then
    echo "Mesh Agent is Running"
    exit 0
else
    echo "Mesh Agent is not Running"
    systemctl start $MeshagentService
    if [ $(systemctl is-active $MeshagentService) = "active" ]; then
        echo "Mesh Agent has been started"
        exit 2
    else
        echo "Mesh Agent could not be started"
        exit 1
    fi
fi

