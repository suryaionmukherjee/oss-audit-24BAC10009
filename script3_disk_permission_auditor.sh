#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: Suryaion Mukherjee | Registration Number: 24BAC10009
# Course: Open Source Software | Capstone Project
# Description: Checks system directories for size and permissions,
#              and locates Git configuration files.
# =============================================================================

# Define the target directories
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share/doc/git")

echo "=================================================================="
echo "              DISK AND PERMISSION AUDIT REPORT"
echo "=================================================================="
echo ""
printf "  %-25s %-20s %-10s\n" "DIRECTORY" "PERMISSIONS/OWNER" "SIZE"
echo "  ---------------------------------------------------------------"

# Loop through the array to check each path
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Grab just the permission string and ownership info
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3 ":" $4}')
        
        # Get folder size, suppressing any 'denied access' errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        
        printf "  %-25s %-20s %-10s\n" "$DIR" "$PERMS ($OWNER)" "${SIZE:-N/A}"
    else
        printf "  %-25s %-20s\n" "$DIR" "[does not exist]"
    fi
done

echo ""
echo "=================================================================="
echo "               GIT CONFIGURATION DIRECTORY CHECK"
echo "=================================================================="
echo ""

# Check standard git config locations
GIT_SYSTEM_CONFIG="/etc/gitconfig"       
GIT_GLOBAL_CONFIG="$HOME/.gitconfig"     
GIT_LOCAL_CONFIG=".git/config"           

# System config check
if [ -f "$GIT_SYSTEM_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONFIG" | awk '{print $1, $3, $4}')
    echo "  [✔] System Git config found: $GIT_SYSTEM_CONFIG"
    echo "      Permissions: $PERMS"
else
    echo "  [–] No system-wide Git config at $GIT_SYSTEM_CONFIG"
fi

# User config check
if [ -f "$GIT_GLOBAL_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_GLOBAL_CONFIG" | awk '{print $1, $3, $4}')
    echo "  [✔] User Git config found: $GIT_GLOBAL_CONFIG"
    echo "      Permissions: $PERMS"
else
    echo "  [–] No user-level Git config at $GIT_GLOBAL_CONFIG"
    echo "      (Run 'git config --global user.name' to create one)"
fi

# Verify the main git binary execution rights
GIT_BIN=$(which git 2>/dev/null)
if [ -n "$GIT_BIN" ]; then
    PERMS=$(ls -l "$GIT_BIN" | awk '{print $1, $3, $4}')
    echo "  [✔] Git binary: $GIT_BIN"
    echo "      Permissions: $PERMS"
    echo "      The binary is world-executable — any user can run git."
else
    echo "  [✘] Git binary not found in PATH."
fi

echo ""
echo "=================================================================="
echo "  WHY PERMISSIONS MATTER IN OPEN SOURCE"
echo "=================================================================="
echo "  Git stores your identity (name, email) in config files."
echo "  If ~/.gitconfig were world-readable on a shared server,"
echo "  other users could read your email and potentially spoof commits."
echo "  Open-source security is not just about code — it's about"
echo "  correct file permissions protecting developer identity."
echo "=================================================================="