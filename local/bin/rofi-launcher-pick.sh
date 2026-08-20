#!/usr/bin/env bash
# Picks a random image for the rofi app-launcher sidebar. Source images live
# in ~/.config/rofi/assets/launcher-images/ (any of them, including gifs —
# only the first frame of a gif is used, rofi cannot animate).
# Pre-crops/caches each source to the sidebar's aspect ratio (1222x1920) so
# rofi never has to guess how to crop it (it doesn't center well on its own).

set -euo pipefail

SRC_DIR="$HOME/.config/rofi/assets/launcher-images"
CACHE_DIR="$HOME/.cache/rofi/launcher-images"
TARGET="$HOME/.config/rofi/assets/launcher-side.png"

mkdir -p "$CACHE_DIR"

mapfile -t sources < <(find "$SRC_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" \) 2>/dev/null)

if [ "${#sources[@]}" -eq 0 ]; then
    exit 0
fi

pick="${sources[RANDOM % ${#sources[@]}]}"
base="$(basename "$pick")"
cached="$CACHE_DIR/${base%.*}.png"

if [ ! -f "$cached" ] || [ "$pick" -nt "$cached" ]; then
    # gif: grab first frame. anything else: flatten as-is.
    src_frame="${pick}[0]"
    magick "$src_frame" -auto-orient \
        -resize "1222x1920^" \
        -gravity center -extent 1222x1920 \
        "$cached"
fi

ln -sf "$cached" "$TARGET"
