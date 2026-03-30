#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: SURYAION MUKHERJEE | Registration Number: 24BAC10009
# Course: Open Source Software | Capstone Project
# Description: Checks if a FOSS package is installed, shows its version,
#              and prints a philosophy note based on the package name.
# =============================================================================

# Target package (our chosen OSS project)
PACKAGE="git"

# Check if the package is installed (works on both RPM and Debian systems)
echo "=================================================================="
echo "           FOSS PACKAGE INSPECTOR — $PACKAGE"
echo "=================================================================="
echo ""

# Detect package manager and check if package is installed
if command -v rpm &>/dev/null; then
    # RPM-based system (Fedora, RHEL, CentOS)
    PKG_MANAGER="rpm"
    if rpm -q $PACKAGE &>/dev/null; then
        PKG_INSTALLED=true
        PKG_INFO=$(rpm -qi $PACKAGE 2>/dev/null)
    else
        PKG_INSTALLED=false
    fi
elif command -v dpkg &>/dev/null; then
    # Debian-based system (This is what will trigger on my GitHub Codespaces Ubuntu environment)
    PKG_MANAGER="dpkg"
    if dpkg -l $PACKAGE 2>/dev/null | grep -q "^ii"; then
        PKG_INSTALLED=true
        PKG_INFO=$(dpkg -l $PACKAGE 2>/dev/null)
    else
        PKG_INSTALLED=false
    fi
else
    # Fallback: try which/version command
    PKG_MANAGER="which"
    if which $PACKAGE &>/dev/null; then
        PKG_INSTALLED=true
    else
        PKG_INSTALLED=false
    fi
fi

# If-then-else: act based on install status
if [ "$PKG_INSTALLED" = true ]; then
    echo "  [✔] $PACKAGE is INSTALLED on this system."
    echo ""
    # Show version regardless of package manager
    GIT_VERSION=$(git --version 2>/dev/null)
    echo "  Version  : $GIT_VERSION"
    # Show install path
    GIT_PATH=$(which git 2>/dev/null)
    echo "  Binary   : $GIT_PATH"
    echo "  Manager  : $PKG_MANAGER"
    echo ""
    # Extract extra package details if running on Fedora/RHEL
    if [ "$PKG_MANAGER" = "rpm" ]; then
        echo "  --- Package Metadata (rpm -qi) ---"
        echo "$PKG_INFO" | grep -E 'Version|License|Summary|URL'
    fi
else
    echo "  [✘] $PACKAGE is NOT installed on this system."
    echo "  To install it:"
    echo "    On RHEL/Fedora  : sudo dnf install git"
    echo "    On Ubuntu/Debian: sudo apt install git"
fi

echo ""
echo "=================================================================="
echo "                    PHILOSOPHY NOTES"
echo "=================================================================="
echo ""

# Case statement: print a philosophy note per package 
# Match the chosen package to its specific open-source history
case $PACKAGE in
    git)
        echo "  Git: Linus Torvalds built Git in 2005 after BitKeeper —"
        echo "  the proprietary VCS Linux used — revoked its free license."
        echo "  Git is proof that a single weekend of open-source work"
        echo "  can outlast any proprietary dependency."
        ;;
    httpd|apache2)
        echo "  Apache: the web server that built the open internet."
        echo "  Born from patchy NCSA httpd, it became the foundation"
        echo "  of the LAMP stack and powers ~30% of all websites."
        ;;
    mysql|mariadb)
        echo "  MySQL: open source at the heart of millions of apps."
        echo "  Its dual GPL/commercial license is a case study in"
        echo "  how open source and business models can coexist."
        ;;
    vlc)
        echo "  VLC: built by students in Paris who just wanted to"
        echo "  stream video over their university network. Now it"
        echo "  plays literally anything — a testament to scratch-your-"
        echo "  own-itch open source development."
        ;;
    python3|python)
        echo "  Python: shaped entirely by its community through PEPs."
        echo "  The PSF license is permissive enough that it powers"
        echo "  everything from NASA scripts to Instagram's backend."
        ;;
    firefox)
        echo "  Firefox: a nonprofit fighting for an open web."
        echo "  When IE dominated with 90%+ market share, Mozilla"
        echo "  proved that open source could compete — and win."
        ;;
    *)
        # Default case for any other package
        echo "  $PACKAGE: part of the vast open-source ecosystem"
        echo "  that powers modern computing. Every package here"
        echo "  represents someone choosing to share rather than hoard."
        ;;
esac

echo ""
echo "=================================================================="
