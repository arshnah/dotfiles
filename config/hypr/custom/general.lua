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
	decoration = {
		blur = {
			enabled = true,
			xray = true,
			size = 4,
			passes = 2,
			new_optimizations = true,
			noise = 0.0117,
			contrast = 1.05,
			vibrancy = 0.2,
			popups = false,
		},
		shadow = {
			enabled = false,
		},
		dim_inactive = true,
	},
	animations = {
		enabled = true,
	},
	misc = {
		focus_on_activate = true,
		anr_missed_pings = 20,
	},
})

