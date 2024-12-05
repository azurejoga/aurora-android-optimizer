#!/bin/bash

# Updating and installing packages using apt
echo "Updating packages and installing adb, git and additional tools..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y adb git

# Cloning the GitHub repository
echo "Cloning the repository..."
git clone https://github.com/azurejoga/aurora-android-optimizer.git

# Navigating to the repository folder
echo "Entering the repository folder..."
cd aurora-android-optimizer || exit 1

# Giving execute permission to the repository folder
echo "Setting execute permissions for the repository folder..."
chmod -R +x .

# Running the final script
echo "Running /scripts/main.sh..."
/scripts/main.sh
