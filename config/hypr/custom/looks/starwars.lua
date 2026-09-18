-- Star Wars look: sharp edges, tight gaps, a lightsaber-red/blue active border.
-- Swapped in over custom/general.lua by `arsh-theme starwars`.

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,
		col = {
			active_border = "rgba(FF3B30FF) rgba(4FC3F7FF) 45deg",
			inactive_border = "rgba(2A2A2E88)",
		},
	},
	decoration = {
		rounding = 2,
		blur = {
			size = 6,
			passes = 3,
			noise = 0.02,
			contrast = 1.1,
			brightness = 0.9,
			vibrancy = 0.15,
			popups = true,
		},
	},
})
