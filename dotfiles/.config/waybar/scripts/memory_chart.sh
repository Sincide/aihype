#!/usr/bin/env bash
# RAM usage sparkline
set -euo pipefail

mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
used=$((mem_total - mem_available))
usage=$((100*used/mem_total))
bars=$((usage/5))
printf 'ram['
for i in $(seq 0 19); do
  if [ $i -lt $bars ]; then printf '#'; else printf '.'; fi
done
printf ']'
