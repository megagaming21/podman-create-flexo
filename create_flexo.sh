#!/bin/bash

# Set cache storage folder
flexo_dir="/srv/cache/flexo"

# Create cache folder with user permissions
sudo mkdir "$flexo_dir"
sudo chown -R $USER:$USER "$flexo_dir"

# Stop and remove existing container
podman stop flexo
podman rm flexo

# Delete cache state files which can cause issues when making a new container.
rm "$flexo_dir"/state/*


clear

# Update to the latest container image
podman pull nroi/flexo

# Create the flexo podman container
podman run -d \
  --name flexo \
  -p 7878:7878 \
  -e FLEXO_LISTEN_IP_ADDRESS=0.0.0.0 \
  -e FLEXO_CACHE_DIRECTORY=/var/cache/flexo \
  -e FLEXO_CONNECT_TIMEOUT=1000 \
  -e FLEXO_MIRROR_SELECTION_METHOD="auto" \
  -e FLEXO_MIRRORS_AUTO_IPV4=true \
  -e FLEXO_MIRRORS_AUTO_IPV6=true \
  -e FLEXO_MIRRORS_AUTO_NUM_MIRRORS=20 \
  -e FLEXO_MIRRORS_AUTO_MIRRORS_RANDOM_OR_SORT="sort" \
  -e FLEXO_MIRRORS_AUTO_TIMEOUT=350 \
  -v "$flexo_dir":/var/cache/flexo \
  nroi/flexo
