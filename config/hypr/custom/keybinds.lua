-- This file will not be overwritten across dots-hyprland updates.
-- The file name is for the sake of organization and does not matter
-- See the corresponding files in ~/.config/hypr/hyprland for examples

hl.unbind("SUPER + B")
hl.bind("SUPER + B", hl.dsp.exec_cmd(
	"env XDG_CONFIG_HOME=$HOME/.config/helium-gtk-override " ..
	"HELIUM_USER_FLAGS='--ozone-platform=wayland --enable-features=WaylandWindowDecorations,UseOzonePlatform,VaapiVideoDecodeLinuxGL,WebRTCPipeWireCapturer,WebUIDarkMode --enable-zero-copy --use-gl=angle --use-angle=gl --enable-smooth-scrolling --force-dark-mode --disable-features=HardwareMediaKeyHandling' " ..
	"helium-browser"
), {
	description = "[Launcher|Apps] Helium browser",
})

hl.unbind("SUPER + SUPER_L")
hl.unbind("SUPER + SUPER_R")

hl.unbind("SUPER + A")
hl.bind("SUPER + A", hl.dsp.global("quickshell:searchToggleRelease"), { description = "Shell: Toggle search/overview" })

hl.unbind("SUPER + ALT + A")
hl.bind("SUPER + ALT + A", hl.dsp.global("quickshell:sidebarLeftToggle"), { description = "Shell: Toggle left sidebar" })

hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("claude-desktop"), {
	description = "[Launcher|Apps] Claude Desktop",
})

local toggle_float_800 = function()
	if not hl.get_active_window() then
		return
	end
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	local active_window = hl.get_active_window()
	if active_window and active_window.floating then
		hl.dispatch(hl.dsp.window.resize({ x = 800, y = 800 }))
		hl.dispatch(hl.dsp.window.center())
	end
end
hl.bind("SUPER + SPACE", toggle_float_800, {
	description = "[Window Management] toggle float, 800x800 (Windows-style)",
})

hl.unbind("SUPER + D")
hl.bind("SUPER + D", hl.dsp.exec_cmd("equibop"), {
	description = "[Launcher|Apps] Equibop (Discord, Equicord + custom WakaTime build)",
})
hl.bind("SUPER + ALT + D", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
	{ description = "Window: Maximize" })
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("kitty --class endcord-float -e ~/Projects/endcord/run-local.sh"), {
	description = "[Launcher|Apps] endcord (terminal Discord client)",
})
hl.bind("SUPER + ALT + I", hl.dsp.exec_cmd("~/Projects/aniani/target/release/aniani"), {
	description = "[Launcher|Apps] aniani (multi-source search/watch/download, floating)",
})

hl.unbind("SUPER + SHIFT + M")
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("spotify"), {
	description = "[Launcher|Apps] Spotify",
})
