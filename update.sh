#!/bin/bash

# Update the package list
sudo apt update

# List upgradable packages
apt list --upgradable

# Upgrade the packages
sudo apt upgrade -y

read -p "Do you want to run 'autoremove' and 'clean'? (y/n): " user_input

# Check if input is true
if [[ "$user_input" == "y" || "$user_input" == "Y" ]]; then
    echo "Running 'sudo apt autoremove -y' and 'sudo apt clean -y'..."
    sudo apt autoremove -y
    sudo apt clean -y
else
    # Do nothing if the input is not 'y' or 'Y'
    :
fi

# Display a message indicating the process is complete
echo "System update and upgrade completed successfully."

# Display the exit code
echo "The exit code for the package upgrade is: $?"
