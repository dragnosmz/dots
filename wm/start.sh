
wm_dir="/users/drgz/wm"

scheme="$2"
monitor="$1"

if [[ "$monitor" == "vga" ]]
then
	# 1920x1080 59.93 Hz
	xrandr --newmode "1920x1080"  138.50  1920 1968 1991 2080  1080 1083 1086 1111 +hsync -vsync
	xrandr --addmode VGA-0 "1920x1080"
	xrandr --output VGA-0 --mode "1920x1080" --primary --output LVDS --off
	echo "Using VGA."
elif [[ "$monitor" == "lvds" ]]
then
	echo "Using LVDS."
fi

if [[ ! -d "$wm_dir/schemes/$scheme" ]]
then
	scheme="floral"
fi

scheme_dir="$wm_dir/schemes/$scheme"

sxhkd -c "$wm_dir/sxhkdrc" >> /dev/null &

xrdb -load "$scheme_dir/Xresources"

xsetroot -cursor_name left_ptr

xset +fp /users/drgz/.local/share/fonts
xset fp rehash

sh "$scheme_dir/setup.sh"

custard 2>> /tmp/custard.log
