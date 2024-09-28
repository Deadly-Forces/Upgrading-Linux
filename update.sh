#!/bin/bash

# Update the package list
sudo apt update

# List upgradable packages
apt list --upgradable

# Upgrade the packages
sudo apt upgrade -y
