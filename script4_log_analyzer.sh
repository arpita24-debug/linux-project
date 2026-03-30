#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: Arpita Gupta | Registration: 24BCE10416
# Course: Open Source Software (OSS NGMC)
# Description: Reads a log file line by line, counts occurrences
#              of a keyword, and prints a summary with last matches.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# =============================================================

# --- Accept command-line arguments ---
LOGFILE=$1                   # First argument: path to log file
KEYWORD=${2:-"error"}        # Second argument: keyword to search (default: "error")

# --- Counter variable to track keyword occurrences ---
COUNT=0

echo "=================================================================="
echo "         Log File Analyzer"
echo "         Student: Arpita Gupta | 24BCE10416"
echo "=================================================================="
echo ""

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "[!] Usage: $0 <logfile_path> [keyword]"
    echo "    Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Check if the file exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "[✗] Error: File '$LOGFILE' not found."
    echo ""

    # --- Do-while style retry: offer fallback log files ---
    echo "  Searching for available log files to use instead..."
    RETRY=0
    MAX_RETRIES=3    # Maximum number of fallback log files to try

    # Array of common fallback log files
    FALLBACKS=("/var/log/syslog" "/var/log/messages" "/var/log/dmesg")

    for FALLBACK in "${FALLBACKS[@]}"; do
        RETRY=$((RETRY + 1))
        if [ -f "$FALLBACK" ]; then
            echo "  [✔] Found fallback log: $FALLBACK"
            LOGFILE="$FALLBACK"   # Use this fallback file instead
            break
        else
            echo "  [✗] Fallback $RETRY/$MAX_RETRIES: $FALLBACK not found."
        fi
    done

    # If no fallback found, exit gracefully
    if [ "$RETRY" -ge "$MAX_RETRIES" ] && [ ! -f "$LOGFILE" ]; then
        echo ""
        echo "  No readable log files found on this system."
        echo "  Try: ./script4_log_analyzer.sh /path/to/your/logfile"
        exit 1
    fi
fi

# --- Check if file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "[!] Warning: '$LOGFILE' exists but is empty. Nothing to analyze."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive search)"
echo ""
echo "--- Scanning log file... ---"
echo ""

# --- While-read loop: read log file line by line ---
# IFS= preserves leading/trailing whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do

    # --- If-then: check if the line contains the keyword (case-insensitive) ---
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter
    fi

done < "$LOGFILE"    # Redirect file as input to the while loop

# --- Print summary ---
echo "  Total lines scanned : $(wc -l < "$LOGFILE")"
echo "  Keyword matches     : $COUNT occurrence(s) of '$KEYWORD'"
echo ""

# --- Print last 5 matching lines for context ---
if [ "$COUNT" -gt 0 ]; then
    echo "--- Last 5 lines matching '$KEYWORD' ---"
    echo ""
    # grep -i for case-insensitive, tail -5 for last 5 matches
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  [i] No lines containing '$KEYWORD' were found in the log."
fi

echo ""
echo "=================================================================="
echo "  Analysis complete."
echo "=================================================================="
