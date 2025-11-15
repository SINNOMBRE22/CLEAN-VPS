#!/bin/bash

# VPS Cleanup Script
# This script is designed to clean up a VPS by removing unnecessary files and packages.

# Update package list
sudo apt-get update

# Remove unused packages
sudo apt-get autoremove -y

# Clean up package cache
sudo apt-get clean

# Remove old log files
sudo find /var/log -name '*.log' -type f -mtime +30 -delete

# Remove temporary files
sudo rm -rf /tmp/*

# Notify the user
echo "Cleanup completed successfully!"