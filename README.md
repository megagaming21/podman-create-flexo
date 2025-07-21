# About
Bash script to create a freshly updated flexo (local pacman cache server) podman container.

"Flexo is a caching proxy for pacman, the package manager of Arch Linux."
https://github.com/nroi/flexo

It basically speeds up pacman downloads, automatically uses fast/latest mirrors, and reduces pacman bandwith usage if you re-install archlinux or have more than one archlinux install.

# Usage
```bash
# This script requires podman, and should be run on the server that will host the pacman cache server.

# Download the script
git clone https://github.com/megagaming21/podman-create-flexo.git

# Make the script executable
cd podman-create-flexo
chmod +x *.sh

# Change the cache directory
nano ./create_flexo.sh

# Run the script
./create_flexo.sh

# A new podman container should now be running
podman ps

# You should probably open the port within your LAN
sudo ufw status
sudo ufw allow from 192.168.1.0/24 to any port 7878
sudo ufw reload
sudo ufw status
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

# Caveats
Sometimes I get an invalid signature or corrupt package error, usually when doing a big update and a package fails to download because it was too slow.

On the client machine just run
```bash
pacman -Scc
```
To clear the pacman cache, the flexo pacman cache server will still have its cache so the pacman update should run quicker and hopefully not give the same error.
```bash
pacman -Syu
```

Otherwise you will need to delete the corrupted package and package signature of the flexo cache
```bash
# On the flexo server
rm /var/cache/flexo/(package)*
```

And run the two pacman commands above on the client machine as well.
