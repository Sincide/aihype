#!/usr/bin/env bash
# Show top CPU and memory consuming process names
set -euo pipefail

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 2 | tail -n 1 | awk '{printf "cpu:%s %s%%", $2, $3}'
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 2 | tail -n 1 | awk '{printf " mem:%s %s%%", $2, $4}'
