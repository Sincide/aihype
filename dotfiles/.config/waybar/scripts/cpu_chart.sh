#!/usr/bin/env bash
# CPU usage with simple sparkline
set -euo pipefail

prev_total=0
prev_idle=0
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
prev_total=$((user+nice+system+idle+iowait+irq+softirq+steal))
prev_idle=$idle
sleep 0.5
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
new_total=$((user+nice+system+idle+iowait+irq+softirq+steal))
new_idle=$idle
usage=$((100*(new_total-prev_total - (new_idle-prev_idle))/(new_total-prev_total)))

bars=$((usage / 5))
printf 'cpu['
for i in $(seq 0 19); do
  if [ $i -lt $bars ]; then printf '#'; else printf '.'; fi
done
printf ']'
