-- Kawaii look: soft rounded windows, wide gaps, a pink/lavender active border.
-- Swapped in over custom/general.lua by `arsh-theme kawaii`.

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 3,
		col = {
			active_border = "rgba(FF8FABFF) rgba(C9A7EBFF) 45deg",
			inactive_border = "rgba(C9A7EB55)",
		},
	},
	decoration = {
		rounding = 18,
		blur = {
			size = 9,
			passes = 4,
			noise = 0.0117,
			contrast = 1.0,
			brightness = 1.05,
			vibrancy = 0.25,
			popups = true,
		},
	},
})
