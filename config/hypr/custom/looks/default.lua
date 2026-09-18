-- This file will not be overwritten across dots-hyprland updates.
-- The file name is for the sake of organization and does not matter
-- See the corresponding files in ~/.config/hypr/hyprland for examples

hl.config({
	input = {
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.35,
		},
	},
	misc = {
		focus_on_activate = true,
		anr_missed_pings = 20,
	},
	decoration = {
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

