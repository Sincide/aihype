# Advanced Dual Waybar

This configuration provides two Waybar instances acting as a command deck and diagnostics bar.

## Bars

```
 +------------------------------------------------------------+
 | Workspaces | Active Window | Mode | Visualizer | Calendar |
 +------------------------------------------------------------+
 | CPU | GPU | RAM | Processes | Net | Battery | VPN | TMUX |
 | Game | Pomodoro | Alerts | Errors |
 +------------------------------------------------------------+
```

Top bar (Command Deck) focuses on window management and quick actions. Bottom bar (Diagnostics) displays system metrics.

## Scripts

| Script | Description |
|--------|-------------|
| `active_window.sh` | Shows active window class and title |
| `wm_mode.sh` | Indicates tiling/float or editor mode |
| `audio_visualizer.sh` | ASCII volume visualizer |
| `calendar_agenda.sh` | Displays date and sends calendar on click |
| `cpu_chart.sh` | CPU usage sparkline |
| `gpu_stats.sh` | NVIDIA GPU stats if available |
| `memory_chart.sh` | Memory usage sparkline |
| `process_hogs.sh` | Reports top CPU/memory processes |
| `net_stats.sh` | Net throughput and packet loss |
| `battery_health.sh` | Battery level and health estimate |
| `vpn_toggle.sh` | Click to toggle WireGuard VPN with latency |
| `tmux_tracker.sh` | Count tmux and ssh sessions |
| `game_mode.sh` | Toggle game mode overlay |
| `pomodoro_timer.sh` | Simple Pomodoro timer |
| `error_log.sh` | Last system error log line |
| `ai_chat.sh` | Launch ChatGPT shell when clicked |
| `modprobe_loader.sh` | Fuzzy load kernel modules |
| `background_tasks.sh` | Warn about temperature spikes |
| `hotplug_reconfigure.sh` | Reload Waybar on monitor hotplug |

Scripts exit gracefully and use `notify-send` for warnings.

Place all scripts in `~/.config/waybar/scripts` and ensure they are executable.
