#!/usr/bin/env bash
# Switches waybar layout (--next/--prev) then, if that layout has a matching
# folder under ~/Pictures/waybar-theme-wallpapers/<layout-name>/, applies one
# of its static wallpapers too. Layouts without a folder there (built-in HyDE
# presets, "minimal" which is wallbash-driven) just get the layout switch.

set -euo pipefail

direction="${1:?usage: waybar-theme-wallpaper.sh --next|--prev}"

python3 /home/arsh/.local/lib/hyde/waybar.py "$direction"

layout_name="$(grep -m1 '^WAYBAR_LAYOUT_NAME=' "$HOME/.local/state/hyde/staterc" 2>/dev/null | cut -d= -f2-)"
[ -z "$layout_name" ] && exit 0

wall_dir="$HOME/Pictures/waybar-theme-wallpapers/$layout_name"
[ -d "$wall_dir" ] || exit 0

# First static (non-gif) image in the folder, alphabetically, for a
# consistent pick rather than a random one on every switch.
wall="$(find "$wall_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort | head -n1)"
[ -n "$wall" ] || exit 0

hyde-shell wallpaper -s "$wall" -G >/dev/null 2>&1 || true
