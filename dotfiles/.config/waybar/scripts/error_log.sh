#!/usr/bin/env bash
# Show last few lines of system log
set -euo pipefail

journalctl -p err -n 1 --no-pager 2>/dev/null | tail -n 1
