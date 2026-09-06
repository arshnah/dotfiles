-- This file will not be overwritten across dots-hyprland updates.
-- The file name is for the sake of organization and does not matter
-- See the corresponding files in ~/.config/hypr/hyprland for examples

hl.layer_rule({ match = { namespace = "launcher" }, animation = "popin 95%" })
hl.layer_rule({ match = { namespace = "overview" }, no_anim = false, animation = "popin 90%" })
hl.layer_rule({ match = { namespace = "quickshell:overview" }, no_anim = false, animation = "popin 90%" })

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
})
