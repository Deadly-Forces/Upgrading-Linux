# Upgrading-LinuxPackage
  Simple program for updating & upgrading your linux system via command line.

## Updated
  1) Progress bars: Show progress or notifications for long-running tasks.
  2) User prompts: More detailed prompts with validation to ensure user input is handled properly.
  3) Additional actions: Optionally upgrade distribution (`dist-upgrade`) and check the system for broken packages (`dpkg --configure`).
  4) Logging: Save logs of the update and upgrade process for later reference.
  5) System info: Display system information like the current kernel version and system uptime.
  6) Colorized output: Use color to improve readability and make it visually engaging.

## Enhancement
  1) Color-coded output: The script uses green, yellow, and red colors to indicate success, info, and error messages respectively.
  2) System information: Displays kernel version and uptime before starting the upgrade.
  3) Progress indicators: Inform the user of the various stages (e.g., updating, upgrading, autoremove).
  4) Logging: Logs all the terminal output into `/var/log/system_update.log` for later review.
  5) Dist-upgrade option: Adds an optional distribution upgrade for more comprehensive package management.
  6) Broken packages check: Ensures that any broken packages are handled.

## Note
  This program uses `sudo`, make sure you have admin permissions.
  The script performs tasks based on user input, and gives clear options at each stage.
  If any errors occur, the script will notify the user and exit, preventing further issues.

# How it Works for Linux:
Package Management: The script works with the `APT` package manager, which is used by Debian-based distributions like Ubuntu, Mint, and others.
1) apt update updates the package list from repositories.
2) apt upgrade installs newer versions of existing packages.
3) apt dist-upgrade is a more comprehensive upgrade that also installs and removes packages if needed (used for upgrading between major versions).
4) apt autoremove removes unused packages that were installed as dependencies and are no longer needed.
5) apt clean clears the local package cache to free up space.

## User Interaction:
  The script interacts with the user by asking for confirmation before performing actions such as upgrading packages, running dist-upgrade, and cleaning the system.

## Error Handling: 
  After each command, the script checks for errors using `$?`. If any command fails, an error message is displayed, and the script exits to prevent further issues.

## Additional Considerations for Linux:
  If you’re running this on a Debian-based Linux distribution (like Ubuntu or Linux Mint), this script should work out of the box.
  Ensure that the user has `sudo` privileges for commands like `sudo apt update` and `sudo apt dist-upgrade`.

## To Run the Script:
  Make the script executable:
    `chmod +x ./update.sh`
  Run the script:
    `sudo ./update.sh`
