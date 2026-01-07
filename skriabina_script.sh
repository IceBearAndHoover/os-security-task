#!/bin/bash

LOGFILE=$1

if [ -z "$LOGFILE" ]; then
    echo "error"
    exit 1
fi

if [ ! -f "$LOGFILE" ]; then
    echo "error LOGFILE not found"
    exit 1
fi

if [ ! -r "$LOGFILE" ]; then
    echo "error"
    exit 1
fi

ERR_COUNT=$(grep -Ei "Failed|Error" "$LOGFILE" | wc -l)
echo "Failed|Error count: $ERR_COUNT"

echo "Last unique 10 IP:"
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$LOGFILE" | sort | uniq | tail -n 10


if [ "$ERR_COUNT" -gt 20 ]; then
    echo "Warning: High error rate detected"
fi