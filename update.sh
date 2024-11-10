#!/bin/bash
# Color variables
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" 
# Display a message in green
function success_message() {
    echo -e "${GREEN}$1${NC}"
}
# Display a message in yellow
function info_message() {
    echo -e "${YELLOW}$1${NC}"
}
# Function to display a message in red
function error_message() {
    echo -e "${RED}$1${NC}"
}

# MAIN Start script
clear
success_message "Starting system update and upgrade process..."

# Display system information
info_message "Current system information:"
uname -a
info_message "Kernel version: $(uname -r)"
info_message "Uptime: $(uptime -p)"

# Update the package list and check for errors
info_message "Updating package list..."
sudo apt update -y
if [ $? -ne 0 ]; then
    error_message "Failed to update package list. Exiting."
    exit 1
fi

# List upgradable packages
info_message "Listing upgradable packages..."
apt list --upgradable

# Ask if user wants to proceed with upgrading
read -p "Do you want to upgrade packages now? (y/n): " upgrade_input
if [[ "$upgrade_input" =~ ^[Yy]$ ]]; then
    info_message "Upgrading packages..."
    sudo apt upgrade -y
    if [ $? -ne 0 ]; then
        error_message "Package upgrade failed. Exiting."
        exit 1
    fi
    success_message "Packages upgraded successfully."
else
    info_message "Skipping package upgrade."
fi

# Ask if user wants to run dist-upgrade
read -p "Do you want to perform a distribution upgrade (dist-upgrade)? (y/n): " dist_upgrade_input
if [[ "$dist_upgrade_input" =~ ^[Yy]$ ]]; then
    info_message "Performing distribution upgrade (dist-upgrade)..."
    sudo apt dist-upgrade -y
    if [ $? -ne 0 ]; then
        error_message "Distribution upgrade failed. Exiting."
        exit 1
    fi
    success_message "Distribution upgrade completed successfully."
else
    info_message "Skipping distribution upgrade."
fi
# Ask if user wants to autoremove old packages and clean the package cache
read -p "Do you want to remove unnecessary packages and clean the cache? (y/n): " autoremove_input
if [[ "$autoremove_input" =~ ^[Yy]$ ]]; then
    info_message "Removing unnecessary packages..."
    sudo apt autoremove -y
    if [ $? -ne 0 ]; then
        error_message "Failed to remove unnecessary packages."
    fi
    info_message "Cleaning the package cache..."
    sudo apt clean -y
    if [ $? -ne 0 ]; then
        error_message "Failed to clean the package cache."
    fi
    success_message "Autoremove and cleaning completed successfully."
else
    info_message "Skipping autoremove and cache cleaning."
fi

# Check for broken packages and fix them
info_message "Checking for broken packages..."
sudo dpkg --configure -a
if [ $? -ne 0 ]; then
    error_message "There were issues configuring packages."
else
    success_message "No broken packages found or fixed successfully."
fi

# Display the process completion message
success_message "System update and upgrade completed successfully."

# Log file path
LOG_FILE="/var/log/system_update_upgrade.log"
info_message "Logging the update process to $LOG_FILE..."

# Save all output to log file
{
    echo "System update and upgrade log: $(date)"
    uname -a
    uname -r
    uptime -p
    sudo apt update
    apt list --upgradable
    sudo apt upgrade -y
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
    sudo apt clean -y
    sudo dpkg --configure -a
    echo "-----------------------------------------"
} >> "$LOG_FILE"
info_message "Log has been saved to $LOG_FILE"

# Display the exit status
echo "The exit code for the package upgrade is: $?"

