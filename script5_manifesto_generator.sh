#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: SURYAION MUKHERJEE | Registration Number: 24BAC10009
# Course: Open Source Software | Capstone Project
# Description: Asks the user three questions interactively, then generates
#              a personalised open-source philosophy statement saved to a file.
# Concepts: read, string concatenation, file writing (>/>>) date command, aliases
# =============================================================================

# --- Alias concept demonstrated via comment ---
# In a real shell session you might use:
#   alias today='date +%d\ %B\ %Y'
# We define the same logic as a variable here since aliases don't work in scripts
TODAY=$(date '+%d %B %Y')
OUTPUT_FILE="manifesto_$(whoami).txt"

# Displaying the welcome banner
echo "=================================================================="
echo "          OPEN SOURCE MANIFESTO GENERATOR"
echo "          OSS Capstone Project | $(date '+%Y')"
echo "=================================================================="
echo ""
echo "  Answer three short questions."
echo "  Your personalised open-source philosophy will be generated"
echo "  and saved to: $OUTPUT_FILE"
echo ""
echo "=================================================================="
echo ""

# Getting user inputs
# using read -p so the prompt stays on the same line as the user's typing

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you?: " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# Input validation: check for empty strings (-z)
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  [!] Please answer all three questions. Exiting."
    exit 1
fi

# Building the manifesto file
# Note: Using > for the very first line to overwrite any existing file from a previous run
# After that, using >> to append the rest of the lines without erasing the file
echo "=================================================================="  > "$OUTPUT_FILE"
echo "  MY OPEN SOURCE MANIFESTO"                                         >> "$OUTPUT_FILE"
echo "  Generated: $TODAY"                                                >> "$OUTPUT_FILE"
echo "=================================================================="  >> "$OUTPUT_FILE"
echo ""                                                                   >> "$OUTPUT_FILE"

# Storing the paragraphs as variables for cleaner code before appending them
PARA1="Every day I rely on $TOOL — a piece of software I did not build, did not pay for, and yet can read, modify, and improve. This is not an accident. Someone made a deliberate choice to share their work with the world, asking only that I extend the same courtesy to others. That choice is the foundation of modern computing."

echo "  $PARA1"   >> "$OUTPUT_FILE"
echo ""           >> "$OUTPUT_FILE"

PARA2="To me, freedom means $FREEDOM. In the context of software, freedom is not just a philosophical ideal — it is a practical guarantee. The freedom to read the source code means I can verify what a program does. The freedom to modify it means I am never trapped by a vendor's decisions. The freedom to redistribute means knowledge does not die when a company does."

echo "  $PARA2"   >> "$OUTPUT_FILE"
echo ""           >> "$OUTPUT_FILE"

PARA3="If I were to build $BUILD and release it under an open-source license, I would be joining a tradition that includes the Linux kernel, Git, Python, and thousands of other tools that quietly run the world. Open source is not charity — it is enlightened self-interest. The code I share today becomes the foundation someone else builds on tomorrow."

echo "  $PARA3"   >> "$OUTPUT_FILE"
echo ""           >> "$OUTPUT_FILE"

# --- Signature ---
echo "  -- $(whoami) | $TODAY"                        >> "$OUTPUT_FILE"
echo ""                                               >> "$OUTPUT_FILE"
echo "==================================================================">> "$OUTPUT_FILE"

# --- Confirm and display the file ---
echo "=================================================================="
echo "  [✔] Manifesto saved to: $OUTPUT_FILE"
echo "=================================================================="
echo ""
cat "$OUTPUT_FILE"
echo ""
echo "=================================================================="
echo "  File written using shell redirection (> and >>)."
echo "  Concepts used: read, string variables, file I/O, date command."
echo "=================================================================="
