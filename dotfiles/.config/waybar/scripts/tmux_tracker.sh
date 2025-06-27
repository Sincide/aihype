#!/usr/bin/env bash
# Display number of tmux/ssh sessions
set -euo pipefail

sessions=$(tmux ls 2>/dev/null | wc -l)
ssh_sessions=$(pgrep ssh | wc -l)

echo "tmux:${sessions} ssh:${ssh_sessions}"
