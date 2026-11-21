#!/usr/bin/env bash
dir="$HOME/Pictures/Wallpapers"
state="$HOME/.cache/current-wallpaper"
pgrep -x awww-daemon >/dev/null || { awww-daemon --no-cache & sleep 0.5; }
set_wall() {
    [ -f "$1" ] || exit 1
    echo "$1" > "$state"
    awww img "$1" --transition-type none
}
case "$1" in
    restore)
        if [ -f "$state" ] && [ -f "$(cat "$state")" ]; then set_wall "$(cat "$state")"; else "$0" random; fi
        ;;
    pick)
        choice=$(find "$dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sed "s|$dir/||" | sort | fuzzel --dmenu)
        [ -n "$choice" ] && set_wall "$dir/$choice"
        ;;
    *)
        set_wall "$(find "$dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)"
        ;;
esac
