#!/usr/bin/env bash
# Monitor background tasks like high temp or fan issues
set -euo pipefail

alerts=""
if sensors >/dev/null 2>&1; then
  temp=$(sensors | awk '/Package id 0:/ {print $4}' | tr -d '+°C')
  if [ -n "$temp" ] && [ "$temp" -gt 90 ]; then
    alerts="HOT";
  fi
fi

echo "$alerts"
