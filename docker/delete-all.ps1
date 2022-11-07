# remove all stopped containers
docker system prune

# remove unused volumes
docker system prune --volumes

# remove all containers
docker ps -a -q | % { docker rm $_ } 

# remove all images
docker images -q | % { docker rmi $_ }