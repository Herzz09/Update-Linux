#!/bin/bash

##########################################################################
clear

#####################################################################
echo ""

#####################################################################
sudo apt update -y
echo ""

sudo apt upgrade -y
echo ""

sudo apt full-upgrade -y
echo ""

#####################################################################
sudo apt dist-upgrade
echo ""

#####################################################################
command -v snap >/dev/null || sudo apt install -y snapd
echo ""

command -v flatpak >/dev/null || sudo apt install -y flatpak
echo ""

command -v fwupdmgr >/dev/null || sudo apt install -y fwupd
echo ""

#####################################################################
sudo systemctl enable --now snapd apparmor
echo ""

sudo snap wait system seed.loaded
echo ""

#####################################################################
sudo snap refresh
echo ""

flatpak update
echo ""

#####################################################################
sudo fwupdmgr refresh
echo ""

sudo fwupdmgr update
echo ""

#####################################################################
sudo apt clean
echo ""

sudo apt autoremove
echo ""

#####################################################################
read -r -p "Do you want to restart the computer now? (y/N): " answer

#####################################################################
if [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]]; then
    echo "Restarting..."
    sudo reboot
else
    echo "Restart canceled."
fi
