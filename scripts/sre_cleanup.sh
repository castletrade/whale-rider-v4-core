#!/bin/bash
# Property of Castle Trade LLC - Operations Division. Unauthorized duplication prohibited.

# SRE Operations Script: Whale Rider Environment Cleanup
# Purpose: Clean shared memory segments, purge stale PIDs, and reset the execution environment.

echo "[$(date)] Initiating SRE environment purge..."

# 1. Terminate any stale Whale Rider processes
TARGET_PROCESS_PATTERN="WhaleRider"
echo "Terminating processes matching: $TARGET_PROCESS_PATTERN"
pkill -f "$TARGET_PROCESS_PATTERN" || echo "No active processes found."

# 2. Cleanup Shared Memory Files (/dev/shm)
# Whale Rider uses memory-mapped files for ultra-low latency IPC
SHM_PATH="/dev/shm"
SHM_PREFIX="whale_rider_shm"

if [ -d "$SHM_PATH" ]; then
    echo "Purging stale shared memory segments from $SHM_PATH..."
    find "$SHM_PATH" -name "${SHM_PREFIX}*" -delete
fi

# 3. Purge Local Logs/Cache (Optional based on retention policy)
find ./logs -name "*.log" -mtime +7 -delete 2>/dev/null

echo "[$(date)] Environment cleanup completed successfully."
