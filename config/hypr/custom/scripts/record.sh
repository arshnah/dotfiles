#!/usr/bin/env bash
if pkill -INT wf-recorder; then
    notify-send "Recording saved" -a Hyprland
    exit 0
fi
out="$(xdg-user-dir VIDEOS)/Recordings"
mkdir -p "$out"
file="$out/recording_$(date '+%Y-%m-%d_%H.%M.%S').mp4"
args=()
[ "$1" = "--sound" ] || [ "$2" = "--sound" ] && args+=(--audio)
if [ "$1" != "--fullscreen" ]; then
    region=$(slurp) || exit 1
    args+=(-g "$region")
fi
notify-send "Recording started" -a Hyprland
wf-recorder "${args[@]}" -f "$file"
