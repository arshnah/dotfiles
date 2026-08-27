-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
	local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
	local entry = share .. "/hypr/hyde.lua"
	local handle = io.open(entry, "r")
	if not handle then
		error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
	end
	handle:close()
	dofile(entry)
end

-- Your Hyprland configuration. HyDE never overwrites this file.
--
-- It loads after HyDE's own binds, so settings here take precedence. Replacing
-- a bind needs more than that: see below. HyDE's defaults live in
-- ~/.local/share/hypr/lua/ and are overwritten on every update, so edits there
-- do not survive.
--
-- Adding a keybind:
--
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(hyde.sh.gamelauncher()), {
--         description = "[Utilities] game launcher",
--     })
--
-- Replacing one of HyDE's: bind the same combination again and yours takes
-- over, but copy its flags across as well. A bind counts as the same one only
-- when its flags match, and `description` is not a flag — miss one and both
-- binds stay live on that combination. Copy the whole options table from
-- ~/.local/share/hypr/lua/key_binds.lua and change only what you need:
--
--     hl.bind("F9", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), {
--         locked = true,
--         description = "[Hardware Controls|Audio] un/mute output",
--     })
--
-- Press SUPER + / to see what is actually loaded, your own binds included.
-- The full reference is KEYBINDINGS.md in the HyDE repository.
--
-- Other Lua files next to this one can be pulled in with require("name").

hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("claude-desktop"), {
	description = "[Launcher|Apps] Claude Desktop",
})

hl.unbind("SUPER + T")
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(hyde.config.app.terminal), {
	description = "[Launcher|Apps] terminal emulator",
})

hl.unbind("SUPER + SHIFT + S")
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(hyde.sh.screenshot.snip()), {
	locked = true,
	description = "[Utilities] partial screenshot capture (Windows-style)",
})

local toggle_float_800 = function()
	if not hl.get_active_window() then
		return
	end
	hl.dispatch(hl.dsp.window.float({action = "toggle"}))
	local active_window = hl.get_active_window()
	if active_window and active_window.floating then
		hl.dispatch(hl.dsp.window.resize({x = 800, y = 800}))
		hl.dispatch(hl.dsp.window.center())
	end
end
hl.bind("SUPER + SPACE", toggle_float_800, {
	description = "[Window Management] toggle float, 800x800 (Windows-style)",
})

hl.config({
	input = {
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.35,
		},
	},
	misc = {
		-- Lets an app's request-to-be-focused (e.g. clicking a notification's
		-- default action) actually switch you to its workspace, instead of
		-- being silently ignored while you're elsewhere.
		focus_on_activate = true,
		-- HyDE's default (5) is trigger-happy on winit/eframe apps (aniani-rust
		-- in particular): the "Application Not Responding" dialog fires while
		-- the process is provably idle underneath (low CPU, every thread
		-- parked on a normal futex_wait/poll, no deadlock) -- confirmed
		-- directly, repeatedly, by checking process/thread state at the exact
		-- moment the dialog appears. A missed xdg_wm_base ping burst, not an
		-- actual hang. Raised so a brief ping delay doesn't get treated as
		-- unresponsive.
		anr_missed_pings = 20,
	},
	decoration = {
		-- HyDE's theme.conf blur (size 6, 3 passes) reads coarse/blocky
		-- behind genuinely transparent windows like Vesktop's mica look —
		-- this file survives HyDE's wallbash reloads (theme.conf doesn't),
		-- so it's the one place that setting actually sticks.
		blur = {
			size = 9,
			passes = 4,
			noise = 0.0117,
			contrast = 1.05,
			brightness = 1.0,
			vibrancy = 0.2,
			popups = true,
		},
	},
})

hl.bind("SUPER + F", hl.dsp.exec_cmd(hyde.config.app.explorer), {
	description = "[Launcher|Apps] file manager (Windows-style)",
})

-- satty (screenshot annotation editor) defaults to the GL renderer, which
-- resamples/blurs its canvas under fractional display scaling on this
-- Intel iGPU. Cairo (software) renders 1:1 and stays sharp.
hl.env("GSK_RENDERER", "cairo")

-- HyDE's own cursor_theme (config.toml) only reaches gsettings/hyprctl at
-- runtime — XWayland apps read XCURSOR_THEME once, at their own startup,
-- so it has to be set here too or they silently keep whatever shipped with
-- the session (this was the actual cause of the theme never visibly
-- changing, not the choice of theme itself).
hl.env("XCURSOR_THEME", "Oxygen_Black")
hl.env("XCURSOR_SIZE", "24")

-- External Dell SE2219HX sits physically to the left of the laptop panel.
hl.monitor({ output = "HDMI-A-1", position = "0x0", mode = "1920x1080@60", scale = "1" })
hl.monitor({ output = "eDP-1", position = "1920x0", mode = "1920x1080@60", scale = "1.25" })

-- Overriding HyDE's default waybar-layout-switch binds (same combo, same
-- description so the keybind hint still shows it under the same category)
-- to also apply that layout's matching wallpaper from
-- ~/Pictures/waybar-theme-wallpapers/<layout-name>/, via
-- ~/.local/bin/waybar-theme-wallpaper.sh. Layouts with no folder there
-- (built-in HyDE presets, "minimal") just get the plain layout switch.
hl.unbind("SUPER + ALT + Up")
hl.bind("SUPER + ALT + Up", hl.dsp.exec_cmd("waybar-theme-wallpaper.sh --next"), {
	description = "[Theming and Wallpaper] next Waybar layout",
})
hl.unbind("SUPER + ALT + Down")
hl.bind("SUPER + ALT + Down", hl.dsp.exec_cmd("waybar-theme-wallpaper.sh --prev"), {
	description = "[Theming and Wallpaper] previous Waybar layout",
})

-- SUPER + S is already HyDE's toggle for the special/scratchpad workspace,
-- so Spotify and rmpc get their own free combos instead.
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("spotify"), {
	description = "[Launcher|Apps] Spotify",
})
hl.bind("SUPER + M", hl.dsp.exec_cmd("kitty --class rmpc-float -e rmpc"), {
	description = "[Launcher|Apps] rmpc (terminal music player)",
})
hl.bind("SUPER + D", hl.dsp.exec_cmd("equibop"), {
	description = "[Launcher|Apps] Equibop (Discord, Equicord + custom WakaTime build)",
})
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("kitty --class endcord-float -e ~/Projects/endcord/run-local.sh"), {
	description = "[Launcher|Apps] endcord (terminal Discord client, local kitty-image patch build)",
})
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("~/Projects/aniani/target/release/aniani"), {
	description = "[Launcher|Apps] aniani (multi-source search/watch/download, floating)",
})
hl.bind("SUPER + ALT + A", hl.dsp.exec_cmd("~/Projects/aniani/target/release/aniani"), {
	description = "[Launcher|Apps] aniani (multi-source search/watch/download, floating) -- alt combo",
})

hl.window_rule({
	name = "rmpc_float",
	tag = "+rmpc_float",
	match = {
		class = "rmpc-float",
	},
	float = true,
	center = true,
	size = "1000 800",
})
hl.window_rule({
	name = "endcord_float",
	tag = "+endcord_float",
	match = {
		class = "endcord-float",
	},
	float = true,
	center = true,
	size = "1000 800",
})
hl.window_rule({
	name = "ani_cli_gui_float",
	tag = "+ani_cli_gui_float",
	match = {
		class = "ani-cli-gui",
	},
	float = true,
	center = true,
	size = "380 560",
})
hl.window_rule({
	name = "aniani_gui_float",
	tag = "+aniani_gui_float",
	match = {
		class = "aniani-gui",
	},
	float = true,
	center = true,
	-- no fixed "size" here anymore -- aniani is a real desktop app now
	-- (1280x800 default) with its own in-app compact-mode toggle that
	-- resizes itself at runtime; a hardcoded windowrule size would just
	-- fight that instead of merely setting the initial launch size.
})
