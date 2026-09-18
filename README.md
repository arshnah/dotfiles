# dotfiles (rivendell branch)

Full replacement of the end-4/dots-hyprland setup on `main`/`end4-migration`
with [zacoons/rivendell-hyprdots](https://codeberg.org/zacoons/rivendell-hyprdots),
a from-scratch Hyprland + quickshell desktop (Skyrim-themed) built for
Hyprland's 4th ricing competition. Adapted for `/home/arsh` and symlinked
into place the same way as the other branches, via `install.sh`.

## What's here

| Path | What |
|---|---|
| `config/hypr` | Hyprland config (flat `hyprland.conf`, not end-4's lua structure), `hypridle.conf`, `style.conf`, `ipclistener.zsh` |
| `config/quickshell` | The bar, launcher, lockscreen, notifications, screenshot overlay — replaces end-4's `ii` shell entirely |
| `config/kitty` | Terminal config + gruvbox themes |
| `config/nvim` | Neovim config (bundled with this theme, replaces the LazyVim one) |
| `config/fastfetch` | Terminal system-info fetch, custom ASCII art |
| `config/zsh` | Minimal `.zshrc`/`.zprofile` (loaded via the existing `ZDOTDIR=~/.config/zsh` mechanism) |
| `assets/` | PNGs/audio the quickshell config references at `~/assets/...` |
| `icons/Skyrim` | Skyrim-themed cursor set |

Everything else (`btop`, `dunst`, `gtk-3.0`, `qt5ct`/`qt6ct`, `Kvantum`,
`fontconfig`, `nwg-look`, `xsettingsd`, `environment.d`, `pypr`,
`wlogout`, `starship`) is untouched from the base branch — rivendell's
upstream repo doesn't configure any of those, and its hyprland.conf doesn't
call rofi or wlogout, so those pieces are effectively unused on this branch
but left in place in case they're wanted (e.g. wlogout for the logout menu).

**Dropped on this branch**: `config/rofi` (rivendell uses its own
quickshell launcher, no rofi), and the end-4 `arsh-theme`
default/starwars/kawaii look-switcher + its wallpapers (that mechanism is
specific to end-4's `custom/general.lua` decoration system, which doesn't
exist here).

## Prerequisites

On Arch/CachyOS, on top of what the base branches already install
(hyprland, quickshell, qt6-5compat, kitty, socat, grim, hyprpicker, upower,
brightnessctl, xdg-desktop-portal-hyprland/gtk, wireplumber/pipewire stack,
mpd — all already present from the end-4 setup):

```bash
sudo pacman -S --needed mpc sox
yay -S --needed mpd-mpris hyprpolkitagent-git ttf-bigblueterminal-nerd
```

**Plugins** — rivendell ships two Hyprland plugins as separate repos, built
via `hyprpm` against your installed Hyprland version:

```bash
hyprpm update
hyprpm add https://codeberg.org/zacoons/ipc-closewindowv2
hyprpm add https://codeberg.org/zacoons/imgborders
hyprpm enable ipc-closewindowv2
hyprpm enable imgborders
```

`hyprpm` builds these against Hyprland's headers for your exact installed
version — if `hyprpm add` fails to build, it's almost always a Hyprland
version mismatch between what the plugin targets and what's installed
(`hyprctl version`), not a config problem here.

## Install

```bash
git clone https://github.com/arshnah/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles && git checkout rivendell
./install.sh
hyprctl reload
```

Everything is symlinked, not copied. Anything already at a target path
that isn't already one of these symlinks gets backed up first
(`<path>.bak.<timestamp>`), never overwritten silently.

## Switching back

The `end4-migration` branch has the previous end-4/quickshell setup fully
intact. To go back: `git checkout end4-migration && ./install.sh &&
hyprctl reload` (your rivendell-branch symlinks get replaced, and anything
that was backed up during this install stays as a `.bak.*` file next to
where it was).

## Attribution

Config content is [zacoons/rivendell-hyprdots](https://codeberg.org/zacoons/rivendell-hyprdots),
only adapted for this machine's home directory and this repo's install
layout. Wallpaper/art credits are in the upstream README.
