#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: Arpita Gupta | Registration: 24BCE10416
# Course: Open Source Software (OSS NGMC)
# Description: Interactively asks the user three questions and
#              generates a personalised open-source philosophy
#              statement saved to a .txt file.
# =============================================================

# --- Alias concept demonstrated via comment ---
# In a real shell session, you could run: alias manifesto='./script5_manifesto.sh'
# This shows how aliases wrap commands for convenience — a core shell concept.
# alias manifesto='bash ~/oss-audit-24BCE10416/script5_manifesto.sh'

echo "=================================================================="
echo "         Open Source Manifesto Generator"
echo "         Student: Arpita Gupta | 24BCE10416"
echo "=================================================================="
echo ""
echo "  Answer three questions to generate your personal open-source"
echo "  philosophy statement. Your manifesto will be saved to a .txt file."
echo ""
echo "------------------------------------------------------------------"

# --- Read user input interactively ---
# 'read -p' displays a prompt and waits for the user to type their answer

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely with the world: " BUILD
echo ""

# --- Validate that none of the answers are empty ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  [!] One or more answers were left blank."
    echo "  Please re-run the script and answer all three questions."
    exit 1
fi

# --- Date command: capture today's date for the manifesto header ---
DATE=$(date '+%d %B %Y')

# --- Determine output filename using string concatenation ---
# $(whoami) gets the current username for a personalised filename
OUTPUT="manifesto_$(whoami).txt"

# --- Compose the manifesto and write to file using > and >> ---

# Write the header (> overwrites if file exists)
echo "=================================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Generated on: $DATE" >> "$OUTPUT"
echo "  Author: $(whoami)" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write the philosophy paragraph using string concatenation of variables
echo "  Every day, I rely on $TOOL — a tool built not for profit," >> "$OUTPUT"
echo "  but as an act of sharing. To me, freedom means $FREEDOM," >> "$OUTPUT"
echo "  and that is exactly what open-source software stands for." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Open source is not just a licence. It is a philosophy that says" >> "$OUTPUT"
echo "  knowledge belongs to everyone. When I look at software like Git," >> "$OUTPUT"
echo "  I see the result of thousands of strangers trusting each other" >> "$OUTPUT"
echo "  enough to build something together." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I commit to this movement. One day, I will build $BUILD" >> "$OUTPUT"
echo "  and I will share it freely — because that is how the giants" >> "$OUTPUT"
echo "  whose shoulders I stand on would have wanted it." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  '$FREEDOM' is not just a word. It is the reason open source exists." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Signed: $(whoami)  |  Date: $DATE" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"

# --- Confirm and display the manifesto ---
echo ""
echo "------------------------------------------------------------------"
echo "  [✔] Manifesto saved to: $OUTPUT"
echo "------------------------------------------------------------------"
echo ""

# Display the generated file using cat
cat "$OUTPUT"

echo ""
echo "=================================================================="
echo "  Share it. Fork it. Build on it. That is the open-source way."
echo "=================================================================="
