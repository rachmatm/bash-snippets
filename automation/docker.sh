#!/bin/bash

# Function 1: Wipe the entire Docker environment
docker_wipe_all() {
    echo "WARNING: This will stop and delete ALL containers, images, and volumes."
    read -p "Are you absolutely sure you want to proceed? (y/N): " confirm

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Operation cancelled. Your Docker environment is safe."
        return 1
    fi

    echo "Starting Docker total wipeout..."

    if [ -n "$(docker ps -q)" ]; then
        echo "Stopping running containers..."
        docker stop $(docker ps -q)
    fi

    if [ -n "$(docker ps -aq)" ]; then
        echo "Removing all containers..."
        docker rm $(docker ps -aq)
    fi

    if [ -n "$(docker images -q)" ]; then
        echo "Removing all images..."
        docker rmi -f $(docker images -q)
    fi

    if [ -n "$(docker volume ls -q)" ]; then
        echo "Removing all volumes..."
        docker volume rm $(docker volume ls -q)
    fi

    echo "Success. Docker environment completely wiped clean."
}

# Function 2: Stop and remove a specific container along with its image and volumes
docker_purge_target() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a container name or ID."
        echo "Usage: docker_purge_target <container_name_or_id>"
        return 1
    fi

    local target=$1

    # Check if container exists
    if ! docker ps -a --format '{{.Names}} {{.ID}}' | grep -q "$target"; then
        echo "Error: Container '$target' not found."
        return 1
    fi

    # Get the image name before removing the container
    local image_id=$(docker inspect --format='{{.Image}}' "$target" 2>/dev/null)
    # Get associated anonymous volumes
    local volumes=$(docker inspect --format='{{range .Mounts}}{{if eq .Type "volume"}}{{.Name}} {{end}}{{end}}' "$target" 2>/dev/null)

    echo "Stopping container: $target"
    docker stop "$target" >/dev/null 2>&1

    echo "Removing container: $target"
    docker rm "$target"

    if [ -n "$image_id" ]; then
        echo "Removing associated image..."
        docker rmi -f "$image_id" 2>/dev/null || echo "Image could not be removed (it may be shared with other containers)."
    fi

    if [ -n "$volumes" ]; then
        echo "Removing associated volumes..."
        for vol in $volumes; do
            docker volume rm "$vol" 2>/dev/null || echo "Volume $vol is still in use."
        done
    fi

    echo "Purge complete for $target."
}

# Function 3: Enter the Bash shell of a running container
docker_enter() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a container name or ID."
        echo "Usage: docker_enter <container_name_or_id>"
        return 1
    fi

    local target=$1

    # Verify container is running
    if ! docker ps --format '{{.Names}} {{.ID}}' | grep -q "$target"; then
        echo "Error: Container '$target' is not running or does not exist."
        return 1
    fi

    echo "Attempting to enter container '$target' via Bash..."
    
    # Try entering with Bash first. If Bash is missing, fallback to Sh.
    if docker exec -it "$target" bash 2>/dev/null; then
        return 0
    else
        echo "Bash not found. Falling back to Sh..."
        docker exec -it "$target" sh
    fi
}
