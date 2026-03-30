#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: Arpita Gupta | Registration: 24BCE10416
# Course: Open Source Software (OSS NGMC)
# Description: Loops through key system directories and reports
#              disk usage, owner, and permissions for each.
#              Also checks Git's config directory permissions.
# =============================================================

# --- Array of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share/doc")

echo "=================================================================="
echo "         Disk and Permission Auditor"
echo "         Student: Arpita Gupta | 24BCE10416"
echo "=================================================================="
echo ""
printf "%-20s %-30s %-10s\n" "DIRECTORY" "PERMISSIONS (perms owner group)" "SIZE"
echo "------------------------------------------------------------------"

# --- For loop: iterate over each directory ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, group using ls and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get human-readable size using du, suppress permission errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # If du returned nothing (e.g., permission denied), mark as N/A
        if [ -z "$SIZE" ]; then
            SIZE="N/A"
        fi

        # Print formatted row
        printf "%-20s %-30s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory does not exist on this system
        printf "%-20s %-30s %-10s\n" "$DIR" "[NOT FOUND]" "-"
    fi
done

echo "------------------------------------------------------------------"
echo ""

# --- Check Git's configuration directory specifically ---
echo "--- Git Configuration Directory Audit ---"
echo ""

# Git stores global config in ~/.gitconfig and system config in /etc/gitconfig
GIT_SYSTEM_CONF="/etc/gitconfig"
GIT_GLOBAL_CONF="$HOME/.gitconfig"
GIT_SHARE_DIR="/usr/share/git-core"

# Check system-level git config
if [ -f "$GIT_SYSTEM_CONF" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONF" | awk '{print $1, $3, $4}')
    echo "  System config (/etc/gitconfig)   : $PERMS"
else
    echo "  System config (/etc/gitconfig)   : [Not found — Git may not be installed system-wide]"
fi

# Check user-level git config
if [ -f "$GIT_GLOBAL_CONF" ]; then
    PERMS=$(ls -l "$GIT_GLOBAL_CONF" | awk '{print $1, $3, $4}')
    echo "  User config (~/.gitconfig)       : $PERMS"
else
    echo "  User config (~/.gitconfig)       : [Not found — no global Git config set]"
fi

# Check Git shared data directory
if [ -d "$GIT_SHARE_DIR" ]; then
    PERMS=$(ls -ld "$GIT_SHARE_DIR" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$GIT_SHARE_DIR" 2>/dev/null | cut -f1)
    echo "  Shared data (/usr/share/git-core): $PERMS | Size: $SIZE"
else
    echo "  Shared data (/usr/share/git-core): [Not found]"
fi

echo ""
# --- Security note ---
echo "--- Security Note ---"
echo "  Directories like /etc store system-wide configs and should be"
echo "  owned by root with restricted write access to prevent tampering."
echo "  Git's /etc/gitconfig is readable by all but writable only by root."
echo ""
echo "=================================================================="
