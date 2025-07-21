# About
Bash script to create a freshly updated flexo (local pacman cache server) podman container.

"Flexo is a caching proxy for pacman, the package manager of Arch Linux."
https://github.com/nroi/flexo

It basically speeds up pacman downloads, automatically uses updated mirrors, and reduces pacman bandwith usage if you re-install archlinux or have more than one archlinux install.

# Usage
```bash
# This script requires podman, and should be run on the server that will host the pacman cache server.

# Download the script
git clone https://github.com/megagaming21/podman-create-flexo.git

# Make the script executable
cd podman-create-flexo
chmod +x *.sh

# Run the script
./create_flexo.sh

# A new podman container should now be running
podman ps
```

# Test the pacman cache server
```bash
# On a separate archlinux machine or container

# Rename the mirror file
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# Use the local pacman cache server as a mirror, assuming its ip address is 192.168.1.7
echo 'Server = http://192.168.1.7:7878/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# This also works for podman/docker containers including build files
RUN echo 'Server = http://192.168.1.7:7878/$repo/os/$arch' > /etc/pacman.d/mirrorlist
```
