#!/usr/bin/env bash
# GPU load, fan speed and power
set -euo pipefail

if command -v nvidia-smi >/dev/null; then
  line=$(nvidia-smi --query-gpu=utilization.gpu,fan.speed,power.draw --format=csv,noheader,nounits 2>/dev/null | head -n1)
  if [ -n "$line" ]; then
    util=$(echo $line | cut -d',' -f1)
    fan=$(echo $line | cut -d',' -f2)
    power=$(echo $line | cut -d',' -f3)
    echo "GPU ${util}% ${fan}% ${power}W"
  fi
else
  echo "GPU N/A"
fi
