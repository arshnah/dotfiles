# dotfiles

My Hyprland desktop setup, built on [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)
(quickshell for the bar/panels, not waybar): window manager, terminal,
launcher, notifications, shell, and theming. Just the visual/config layer,
symlinked into place with `install.sh`. No secrets, no caches, no app data.

## What's here

| Path | What |
|---|---|
| `config/hypr` | Hyprland config (end-4's lua-based structure), shaders, hyprlock/hypridle/hyprsunset |
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
| `config/hypr/custom/looks` | Optional decoration presets (`default`, `starwars`, `kawaii`), see below |
| `config/hypr/hyprlock/{StarWars,Kawaii}.conf` | Matching optional hyprlock presets |
| `wallpapers/{StarWars,Kawaii}` | Curated wallpapers for the optional themes |
| `local/bin` | `rofi-launcher-pick.sh` (random launcher sidebar image), `arsh-theme` (theme switcher) |

The bar/panels themselves are [quickshell](https://quickshell.outfoxxed.me)
running end-4's `ii` shell config, which lives in its own repo at
`~/.config/quickshell/ii` and isn't tracked here.

**Not included on purpose**: anything with real credentials (`gh`, Discord
bot tokens, scrobbler passwords), browser profiles, and IDE/app caches. All
of that either doesn't belong in git or comes back automatically when you
install the actual tools below.

## Prerequisites

This is a personalization layer **on top of [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)**,
not a from-scratch Hyprland setup. Install that first, then apply this repo.

On Arch/CachyOS:

```bash
# end-4/dots-hyprland itself (brings Hyprland, quickshell, rofi, dunst, theming engine, etc.)
git clone --depth 1 https://github.com/end-4/dots-hyprland ~/dots-hyprland
cd ~/dots-hyprland && ./install.sh

# extras this setup uses on top of a stock install
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

## Optional themes

Two extra desktop looks ship alongside the default, entirely opt-in:

- **starwars** — lightsaber red/blue gradient border, sharp corners, tight
  gaps, a black-and-gold opening-crawl hyprlock, and Star Wars art in the
  rofi launcher sidebar.
- **kawaii** — pink/lavender gradient border, heavily rounded windows, wide
  gaps, a soft pastel hyprlock, and cute art in the rofi launcher sidebar.

Switch with:

```bash
arsh-theme starwars   # or: kawaii / default
```

This swaps the Hyprland decoration (`custom/general.lua`), the hyprlock
preset, and the rofi launcher sidebar's image pool, then reloads Hyprland.
It does **not** touch your wallpaper — press `Ctrl+Super+T` to open the
Quickshell wallpaper picker and pick one from `~/Pictures/Wallpapers/StarWars`
or `~/Pictures/Wallpapers/Kawaii` (copy the ones from `wallpapers/` in this
repo there first, or drop in your own).
