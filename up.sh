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
command -v snap >/dev/null || sudo apt install -y snapd

command -v flatpak >/dev/null || sudo apt install -y flatpak

command -v fwupdmgr >/dev/null || sudo apt install -y fwupd

#####################################################################
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
    sleep 3
    exit
fi
