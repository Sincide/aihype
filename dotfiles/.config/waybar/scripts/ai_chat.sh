#!/usr/bin/env bash
# Launch AI chat client
set -euo pipefail

if command -v chatgpt-shell >/dev/null; then
  exec chatgpt-shell
else
  notify-send "AI Chat" "chatgpt-shell not installed"
fi
