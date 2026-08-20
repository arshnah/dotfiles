# dotfiles

My Hyprland/HyDE desktop setup: window manager, bar, terminal, launcher,
notifications, shell, and theming. Just the visual/config layer, symlinked
into place with `install.sh`. No secrets, no caches, no app data.

## What's here

| Path | What |
|---|---|
| `config/hypr` | Hyprland config, `hyprland.lua`, shaders, hyprlock/hypridle/hyprsunset |
| `config/waybar` | Bar layouts + styles |
| `config/kitty` | Terminal config |
| `config/rofi` | App launcher theme (`style_1`, launcher-image sidebar) |
| `config/dunst` | Notifications |
| `config/zsh` | Shell config, aliases |
| `config/starship` | Shell prompt |
| `config/wlogout` | Logout menu |
| `config/gtk-3.0`, `gtkrc`, `gtkrc-2.0` | GTK theming |
| `config/qt5ct`, `config/qt6ct`, `config/Kvantum` | Qt theming |
| `config/fontconfig` | Font aliases |
| `config/nwg-look` | GTK theme picker settings |
| `config/xsettingsd` | Cursor/theme sync for X apps |
| `config/pypr` | Pyprland (scratchpads etc.) |
| `config/btop` | System monitor theme |
| `config/fastfetch` | Terminal system-info fetch |
| `config/environment.d` | Cursor size/theme env vars |
| `config/nvim` | Neovim (LazyVim-based) |
| `config/hyde` | HyDE's `config.toml`, `wallbash`, and my custom **Minimal** theme only. The other stock HyDE themes ship with HyDE itself, not tracked here |
| `local/bin` | `rofi-launcher-pick.sh` (random launcher sidebar image), `waybar-theme-wallpaper.sh` |

**Not included on purpose**: anything with real credentials (`gh`, Discord
bot tokens, scrobbler passwords), browser profiles, IDE/app caches, and the
11 stock HyDE preset themes. All of that either doesn't belong in git or
comes back automatically when you install the actual tools below.

## Prerequisites

This is a personalization layer **on top of [HyDE](https://github.com/HyDE-Project/HyDE)**,
not a from-scratch Hyprland setup. Install HyDE first, then apply this repo.

On Arch/CachyOS:

```bash
# HyDE itself (brings Hyprland, waybar, rofi, dunst, the theme/wallbash engine, etc.)
git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
cd ~/HyDE/Scripts && ./install.sh

# extras this setup uses on top of a stock HyDE install
sudo pacman -S --needed kitty starship wlogout nwg-look qt5ct qt6ct btop fastfetch
yay -S --needed pyprland capitaine-cursors
```

**Fonts**: [Maple Mono NF](https://github.com/subframe7536/maple-font).
Install to `~/.local/share/fonts/MapleMono-NF/` and rebuild the font cache
(`fc-cache -f`).

**Cursor**: `capitaine-cursors`, size 24. Set via `nwg-look` or
`hyprctl setcursor capitaine-cursors 24`.

## Install

```bash
git clone https://github.com/arshnah/dotfiles.git ~/Projects/dotfiles
~/Projects/dotfiles/install.sh
hyprctl reload
```

Everything is symlinked, not copied, so editing the files in this repo
changes them live. Anything already at a target path that isn't already one
of these symlinks gets backed up first (`<path>.bak.<timestamp>`), never
overwritten silently.

## Notes

- `config/hyde/wallbash` is the color-extraction engine that themes waybar,
  hyprlock, kitty etc. off your wallpaper. It needs an actual wallpaper set
  to generate a palette (`SUPER+SHIFT+W` in Hyprland, or `hyde-shell
  theme.switch -s "Minimal"`).
- `~/.local/lib/hyde/waybar.py` and `theme.switch.sh` are patched on my
  machine (theme→waybar auto-switch hook), but they live inside HyDE's own
  managed library, so they're not tracked here and can get overwritten by a
  HyDE update. The patch is one `case` block; see the session notes if it
  needs re-adding.
