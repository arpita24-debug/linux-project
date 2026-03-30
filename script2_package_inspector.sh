#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: Arpita Gupta | Registration: 24BCE10416
# Course: Open Source Software (OSS NGMC)
# Description: Checks if a FOSS package is installed, shows
#              version/license info, and prints a philosophy note.
# =============================================================

# --- Package to inspect (Git is our chosen software) ---
PACKAGE="git"

echo "=================================================================="
echo "         FOSS Package Inspector"
echo "=================================================================="
echo ""

# --- Check if package is installed using if-then-else ---
# Try dpkg first (Debian/Ubuntu), fall back to rpm (RedHat/Fedora), then 'which'
if dpkg -l "$PACKAGE" &>/dev/null 2>&1; then
    # Package found via dpkg
    echo "[✔] $PACKAGE is INSTALLED on this system."
    echo ""
    echo "--- Package Details (dpkg) ---"
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "  Package : "$2"\n  Version : "$3"\n  Arch    : "$4}'
    echo ""
    # Get more details using dpkg-query
    dpkg-query -s "$PACKAGE" 2>/dev/null | grep -E "^(Package|Version|Maintainer|Homepage|Description):" | \
        awk -F: '{print "  "$1" :"$2}'

elif rpm -q "$PACKAGE" &>/dev/null 2>&1; then
    # Package found via rpm
    echo "[✔] $PACKAGE is INSTALLED on this system."
    echo ""
    echo "--- Package Details (rpm) ---"
    rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
        awk '{print "  "$0}'

elif which "$PACKAGE" &>/dev/null 2>&1; then
    # Package found via PATH (manually installed or different package manager)
    echo "[✔] $PACKAGE is INSTALLED (found via PATH)."
    echo ""
    echo "--- Version Info ---"
    echo "  Path    : $(which $PACKAGE)"
    echo "  Version : $($PACKAGE --version 2>/dev/null | head -1)"

else
    # Package not found
    echo "[✗] $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install on Debian/Ubuntu : sudo apt install $PACKAGE"
    echo "  To install on RedHat/Fedora : sudo dnf install $PACKAGE"
fi

echo ""
echo "------------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------------"

# --- Case statement: print philosophy note based on package name ---
case $PACKAGE in
    git)
        echo "  Git: Born from Linus Torvalds' frustration with proprietary VCS."
        echo "  'I'm an egotistical bastard, and I name all my projects after myself.'"
        echo "  GPL v2 — the same license that guards the Linux kernel itself."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Apache License 2.0 — permissive, business-friendly, and open."
        ;;
    mysql | mariadb)
        echo "  MySQL/MariaDB: Open source at the heart of millions of web apps."
        echo "  Dual-licensed — a lesson in how commerce and community can coexist."
        ;;
    firefox)
        echo "  Firefox: A nonprofit's stand for an open, unmonopolised web."
        echo "  MPL 2.0 — Mozilla's balance between openness and practicality."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to stream video."
        echo "  LGPL/GPL — proof that student projects can change the world."
        ;;
    python3 | python)
        echo "  Python: A language shaped entirely by its community, not a corporation."
        echo "  PSF License — permissive and welcoming to all contributors."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice."
        echo "  MPL 2.0 — a real-world lesson in why community governance matters."
        ;;
    *)
        echo "  $PACKAGE: Every open-source tool stands on a foundation of shared freedom."
        echo "  The right to study, modify, and distribute is the heart of FOSS."
        ;;
esac

echo ""
echo "=================================================================="
