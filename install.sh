#!/usr/bin/env bash
# Symlinks this repo's tracked configs into ~/.config, ~/assets, ~/.icons
# and ~/.local/bin. Anything already there that isn't already one of our
# symlinks gets backed up first (suffixed .bak.<timestamp>), never
# overwritten silently.
#
# This branch (rivendell) is a full replacement of end-4/dots-hyprland with
# zacoons' rivendell-hyprdots (https://codeberg.org/zacoons/rivendell-hyprdots):
# its own quickshell shell, hyprland.conf, kitty/nvim/fastfetch config, the
# Skyrim cursor theme, and two hyprpm plugins. See README.md.
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

echo "== assets =="
link "$DOTFILES/assets" "$HOME/assets"

echo "== icons =="
link "$DOTFILES/icons/Skyrim" "$HOME/.icons/Skyrim"

echo
echo "Done. Reload with: hyprctl reload"
echo
echo "Still needed (see README.md):"
echo "  - packages: mpc mpd-mpris sox hyprpolkitagent ttf-bigblueterminal-nerd"
echo "  - hyprpm plugins: ipc-closewindowv2, imgborders"
echo "  - set the Skyrim icon theme's index.theme cursor, or via nwg-look/gsettings"
