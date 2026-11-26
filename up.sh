#!/bin/bash

##########################################################################
clear

#####################################################################
echo ""

#####################################################################
sudo apt update -y
sudo apt upgrade -y
sudo apt full-upgrade -y

#####################################################################
sudo apt dist-upgrade

#####################################################################
# Install Snap, Flatpak and fwupd only if they are missing
command -v snap >/dev/null || sudo apt install -y snapd
command -v flatpak >/dev/null || sudo apt install -y flatpak
command -v fwupdmgr >/dev/null || sudo apt install -y fwupd

# Enable the services Snap needs and wait until it is ready
sudo systemctl enable --now snapd apparmor
sudo snap wait system seed.loaded

#####################################################################
sudo snap refresh
flatpak update

#####################################################################
sudo fwupdmgr refresh
sudo fwupdmgr update

#####################################################################
sudo apt clean
sudo apt autoremove

#####################################################################
echo ""
read -r -p "Do you want to restart the computer now? (y/N): " answer

#####################################################################
if [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]]; then
    echo "Restarting..."
    sudo reboot
else
    echo "Restart canceled."
fi
