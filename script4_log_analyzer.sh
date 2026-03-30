#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: SURYAION MUKHERJEE | Registration Number: 24BAC10009
# Course: Open Source Software | Capstone Project
# Description: Reads a log file line by line, counts keyword occurrences,
#              prints a summary, and shows the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh /var/log/syslog [KEYWORD]
#        ./script4_log_analyzer.sh /var/log/messages error
# =============================================================================

# Command-line arguments
# $1 = path to log file (required)
# $2 = keyword to search for (optional, defaults to "error")
LOGFILE=$1
KEYWORD=${2:-"error"}    # Default keyword is 'error' if not provided

# Counter variable to track keyword hits
COUNT=0

echo "=================================================================="
echo "                    LOG FILE ANALYZER"
echo "=================================================================="
echo ""

# Validate: make sure a log file argument was provided
if [ -z "$LOGFILE" ]; then
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# Retry loop: if file not found, ask user once more (do-while style)
# Bash doesn't have do-while natively; we simulate it with a while loop and break
ATTEMPTS=0
MAX_ATTEMPTS=2

while [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; do
    if [ -f "$LOGFILE" ]; then
        # File found — exit the retry loop
        break
    else
        ATTEMPTS=$((ATTEMPTS + 1))
        echo "  [!] Attempt $ATTEMPTS: File '$LOGFILE' not found."
        if [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; then
            # Ask user to provide a different path
            read -p "  Enter a different log file path (or press Enter to abort): " NEW_PATH
            if [ -z "$NEW_PATH" ]; then
                echo "  Aborting."
                exit 1
            fi
            LOGFILE="$NEW_PATH"
        else
            echo "  Maximum attempts reached. Exiting."
            exit 1
        fi
    fi
done

echo "  Analyzing : $LOGFILE"
echo "  Keyword   : '$KEYWORD'"
echo ""

# Check if file is empty
if [ ! -s "$LOGFILE" ]; then
    echo "  [!] Warning: The log file is empty. Nothing to analyze."
    exit 0
fi

# While-read loop: read the log file line by line
# IFS= prevents trimming of leading/trailing whitespace
# -r prevents backslash interpretation
while IFS= read -r LINE; do
    # if-then: check if current line contains the keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter for each matching line
    fi
done < "$LOGFILE"    # Redirect file content into the while loop

# Print summary
# Using '<' feeds the file contents to wc so it only prints the number, not the filename
echo "  ---------------------------------------------------------------"
echo "  Total lines scanned : $(wc -l < "$LOGFILE")"
echo "  Keyword hits        : $COUNT lines containing '$KEYWORD'"
echo "  ---------------------------------------------------------------"
echo ""

# Print last 5 matching lines for context
echo "  Last 5 lines matching '$KEYWORD':"
echo "  ---------------------------------------------------------------"

# Use grep to find all matches, then tail to get last 5
# 2>/dev/null suppresses any "permission denied" error messages from cluttering the output
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" 2>/dev/null | tail -5)

if [ -n "$MATCHES" ]; then
    # Print each match with a leading marker
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  (No matches found)"
fi

echo ""
echo "=================================================================="
echo "  WHY LOG ANALYSIS MATTERS FOR OPEN SOURCE"
echo "=================================================================="
echo "  Git itself writes logs — .git/logs/ stores every ref update."
echo "  Tools like journalctl and syslog are open-source and GPL-licensed."
echo "  Transparency in logging is a core open-source value: if something"
echo "  goes wrong, the community can read, audit, and fix it."
echo "=================================================================="
