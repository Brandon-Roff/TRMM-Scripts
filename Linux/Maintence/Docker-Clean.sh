# This Script will cleap up all the docker images and containers, networks and volumes that are not in use.
# This script will exlude stopped containers that are not in use.

# Check if docker is installed
if [ -f /usr/bin/docker ]; then
    echo "Docker is installed... Proceeding"
else
    echo "Docker is not installed... Please install docker tp proceed"
    exit 2
fi

# Start withh cleaning up the containers but exclude the stopped containers

echo "Cleaning up containers"
docker container prune -f --filter "status=exited" >> /tmp/docker-clean.log
echo "Containers cleaned up"
echo ""

# Clean up the images
echo "Cleaning up images"
docker image prune -f --filter "dangling=true" >> /tmp/docker-clean.log
echo "Images cleaned up"
echo ""

# Clean up the volumes
echo "Cleaning up volumes"
docker volume prune -f  --filter "dangling=true" >> /tmp/docker-clean.log
echo "Volumes cleaned up"
echo ""

# Clean up the networks
echo "Cleaning up networks..."
docker network prune -f --filter "dangling=true" >> /tmp/docker-clean.log
echo "Networks cleaned up"
echo ""

echo "All done"