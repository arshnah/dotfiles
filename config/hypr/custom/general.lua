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
			enabled = false,
		},
		shadow = {
			enabled = false,
		},
		dim_inactive = false,
	},
	animations = {
		enabled = false,
	},
	misc = {
		focus_on_activate = true,
		anr_missed_pings = 20,
	},
})

