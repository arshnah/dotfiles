#!/bin/zsh

handle() {
	case $1 in
		openwindow*)
			class=$(echo $1 | cut -d',' -f3)
			if [ "$class" = "kitty" ]; then
				play --no-show-progress ~/assets/paper-open.wav
			fi
		;;
		closewindowv2*)
			class=$(echo $1 | cut -d',' -f2)
			if [ "$class" = "kitty" ]; then
				play --no-show-progress ~/assets/paper-close.wav
			fi
		;;
	esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
