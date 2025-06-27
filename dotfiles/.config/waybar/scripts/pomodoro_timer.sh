#!/usr/bin/env bash
# Simple pomodoro timer
set -euo pipefail

state_dir="$HOME/.cache/pomodoro"
mkdir -p "$state_dir"
start_file="$state_dir/start"

if [ "${1:-}" = "toggle" ]; then
  if [ -f "$start_file" ]; then
    rm -f "$start_file"
    notify-send "Pomodoro" "Stopped"
  else
    date +%s > "$start_file"
    notify-send "Pomodoro" "Started"
  fi
  exit 0
fi

if [ -f "$start_file" ]; then
  start=$(cat "$start_file")
  now=$(date +%s)
  remain=$((1500 - (now - start)))
  if [ $remain -le 0 ]; then
    rm -f "$start_file"
    notify-send "Pomodoro" "Time's up" && exit 0
  fi
  mins=$((remain/60))
  secs=$((remain%60))
  printf '%02d:%02d' "$mins" "$secs"
fi
