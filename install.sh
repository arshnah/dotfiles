#!/usr/bin/env bash
# Symlinks this repo's tracked configs into ~/.config and ~/.local/bin.
# Anything already there that isn't already one of our symlinks gets backed
# up first (suffixed .bak.<timestamp>), never overwritten silently.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.bak.$(date +%s)"
    echo "backed up existing $dest"
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

echo "== config/* =="
for d in "$DOTFILES"/config/*/; do
  name="$(basename "$d")"
  link "$d" "$HOME/.config/$name"
done

echo "== local/bin =="
for f in "$DOTFILES"/local/bin/*; do
  name="$(basename "$f")"
  link "$f" "$HOME/.local/bin/$name"
  chmod +x "$HOME/.local/bin/$name"
done

echo "== optional theme wallpapers =="
for name in StarWars Kawaii; do
  src="$DOTFILES/wallpapers/$name"
  dest="$HOME/Pictures/Wallpapers/$name"
  [ -d "$src" ] || continue
  mkdir -p "$dest"
  cp -n "$src"/* "$dest"/ 2>/dev/null || true
  echo "copied $name wallpapers -> $dest"
done

echo
echo "Done. Reload with: hyprctl reload"
echo "(end-4/dots-hyprland, Hyprland, quickshell, kitty, rofi etc. themselves must already be installed — see README.)"
echo "Optional themes: run 'arsh-theme starwars' or 'arsh-theme kawaii' (see README)."
