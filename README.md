Markdown

# OSS Audit - Git Open Source Software Capstone Project | VITyarthi

| Field | Details |
|-------|---------|
| **Student Name** | Suryaion Mukherjee |
| **Registration Number** | 24BAC10009 |
| **Course** | Open Source Software (OSS NGMC) |
| **Chosen Software** | Git - Distributed Version Control System |
| **License** | GNU General Public License v2 (GPL v2) |

## About the Project

This repository contains the shell scripts for the OSS Capstone Project: The Open Source Audit. The chosen software is **Git**, a distributed version control system created by Linus Torvalds in 2005.

The project audits Git across five dimensions: its origin story and philosophy, its Linux footprint, the FOSS ecosystem it belongs to, a comparison with proprietary alternatives, and practical shell scripts demonstrating Linux skills.

## Repository Structure
oss-audit-24BAC10009/
|-- README.md
|-- script1_system_identity.sh        # System Identity Report
|-- script2_package_inspector.sh      # FOSS Package Inspector
|-- script3_disk_permission_auditor.sh # Disk and Permission Auditor
|-- script4_log_analyzer.sh           # Log File Analyzer
|-- script5_manifesto_generator.sh    # Open Source Manifesto Generator

## Scripts Overview

*Script 1 - System Identity Report*
Displays a welcome screen with the Linux distribution, kernel version, current user, home directory, system uptime, date/time, and the GPL v2 licence covering the OS.
Concepts: Variables, command substitution $(), echo, uname, uptime, date, cat /etc/os-release

*Script 2 - FOSS Package Inspector*
Checks whether Git is installed, shows its version and binary path, and prints a philosophy note about Git and other well-known FOSS packages using a case statement.
Concepts: if-then-else, case statement, rpm -qi / dpkg -l, grep -E, which, command -v

*Script 3 - Disk and Permission Auditor*
Loops through key system directories (/etc, /var/log, /home, /usr/bin, /tmp) and reports permissions, ownership, and size. Also checks Git's configuration file locations.
Concepts: for loop with array, [ -d ] test, ls -ld, awk, du -sh, cut, printf for aligned output

*Script 4 - Log File Analyzer*
Reads a log file line by line, counts occurrences of a keyword (default: error), implements a retry loop if the file is not found, and prints the last 5 matching lines.
Concepts: Command-line arguments ($1, $2), ${VAR:-default}, while IFS= read -r loop, if-then inside loop, counter arithmetic, tail + grep pipeline

*Script 5 - Open Source Manifesto Generator*
Asks the user three interactive questions and generates a personalised open-source philosophy statement, saved to a .txt file.
Concepts: read -p for interactive input, string interpolation, file writing with > and >>, date, whoami, input validation, alias concept

## How to Run the Scripts
*Prerequisites*
A Linux system (Ubuntu, Fedora, Debian, CentOS, or any standard distro)
Bash shell (version 4+) - check with bash --version
Git installed - check with git --version
Step 1: Clone the repository
Bash

git clone [https://github.com/suryaionmukherjee/oss-audit-24BAC10009.git](https://github.com/suryaionmukherjee/oss-audit-24BAC10009.git)cd oss-audit-24BAC10009
Step 2: Make scripts executable
Bash

chmod +x *.sh
Step 3: Run each script

Script 1 - System Identity Report
Bash

./script1_system_identity.sh
No arguments needed. Simply run and observe the output.

Script 2 - FOSS Package Inspector
Bash

./script2_package_inspector.sh
No arguments needed. The script checks for git by default. Edit the PACKAGE variable to check other software.

Script 3 - Disk and Permission Auditor
Bash

./script3_disk_permission_auditor.sh
No arguments needed. The script audits a predefined list of directories.

Script 4 - Log File Analyzer
Bash

Basic usage - search for 'error' in a log file
./script4_log_analyzer.sh /var/log/syslog# Custom keyword
./script4_log_analyzer.sh /var/log/syslog WARNING# On Ubuntu, syslog might be at:
./script4_log_analyzer.sh /var/log/syslog error# On Fedora/RHEL, try:
./script4_log_analyzer.sh /var/log/messages error

Script 5 - Open Source Manifesto Generator
Bash

./script5_manifesto_generator.sh
Follow the interactive prompts. The generated manifesto is saved to manifesto_[username].txt in the current directory.

## Dependencies
| Dependency | Required By | Install Command |
|------------|-------------|-----------------|
| `bash` | All scripts | Pre-installed on all Linux distros |
| `git` | Script 2 | `sudo apt install git` or `sudo dnf install git` |
| `coreutils` (uname, uptime, date, whoami, du, ls) | Scripts 1, 3 | Pre-installed |
| `grep` | Scripts 2, 4 | Pre-installed |
| `awk` | Scripts 3 | Pre-installed (part of gawk) |

## Notes
Scripts are written for bash specifically. Running with sh may cause issues on systems where sh is dash (e.g., Ubuntu).
Script 3 uses du -sh which may show permission denied errors for some system directories - this is expected and harmless (stderr is suppressed).
Script 4 requires a readable log file. Use the test log example above if system logs are restricted.
All scripts include inline comments explaining each section as required by the project rubric.

