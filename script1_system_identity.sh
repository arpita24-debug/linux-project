#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: Arpita Gupta | Registration: 24BCE10416
# Course: Open Source Software (OSS NGMC)
# Description: Displays a welcome screen with Linux system info
#              and license details relevant to the chosen OSS project.
# =============================================================

# --- Variables ---
STUDENT_NAME="Arpita Gupta"         # Student's full name
REG_NO="24BCE10416"                  # Registration number
SOFTWARE_CHOICE="Git"                # Chosen open-source software

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                   # Current Linux kernel version
DISTRO=$(cat /etc/os-release 2>/dev/null | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"')
# Fallback if /etc/os-release is unavailable
if [ -z "$DISTRO" ]; then
    DISTRO=$(uname -s)
fi
USER_NAME=$(whoami)                  # Current logged-in username
HOME_DIR=$HOME                       # Home directory of the current user
UPTIME=$(uptime -p 2>/dev/null || uptime)   # Human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y') # Formatted current date
CURRENT_TIME=$(date '+%H:%M:%S %Z')  # Current time with timezone

# --- License message for Git (GPL v2) ---
LICENSE_MSG="Git is licensed under the GNU General Public License v2 (GPL v2) — free as in freedom."

# --- Display formatted output ---
echo "=================================================================="
echo "         OPEN SOURCE AUDIT — System Identity Report              "
echo "=================================================================="
echo ""
echo "  Student   : $STUDENT_NAME ($REG_NO)"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------------"
echo "  Distribution  : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME_DIR"
echo "  System Uptime : $UPTIME"
echo "  Date          : $CURRENT_DATE"
echo "  Time          : $CURRENT_TIME"
echo ""
echo "------------------------------------------------------------------"
echo "  LICENSE INFO"
echo "------------------------------------------------------------------"
echo "  $LICENSE_MSG"
echo ""
echo "=================================================================="
echo "  'Free software is a matter of liberty, not price.' — RMS"
echo "=================================================================="
