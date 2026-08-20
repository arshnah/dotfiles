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
  [ "$name" = "hyde" ] && continue
  link "$d" "$HOME/.config/$name"
done

echo "== hyde (config.toml, wallbash, and just the Minimal theme — the rest ship with HyDE itself) =="
link "$DOTFILES/config/hyde/config.toml" "$HOME/.config/hyde/config.toml"
link "$DOTFILES/config/hyde/wallbash" "$HOME/.config/hyde/wallbash"
mkdir -p "$HOME/.config/hyde/themes"
link "$DOTFILES/config/hyde/themes/Minimal" "$HOME/.config/hyde/themes/Minimal"

echo "== local/bin =="
for f in "$DOTFILES"/local/bin/*; do
  name="$(basename "$f")"
  link "$f" "$HOME/.local/bin/$name"
  chmod +x "$HOME/.local/bin/$name"
done

echo
echo "Done. Reload with: hyprctl reload"
echo "(HyDE, Hyprland, waybar, kitty, rofi etc. themselves must already be installed — see README.)"
