#!/bin/bash

pgrep -x sxhkd > /dev/null || sxhkd &


# Wallpaper
# ---------------------------------------------
nitrogen --set-zoom-fill --random /home/ddimitrov/Pictures/RiceWallpapers --save &


# Picom
# ---------------------------------------------
pgrep picom || picom --config $HOME/.config/picom/picom.conf &


# Dunst (notifications)
# ---------------------------------------------
#dunst &


# Launch Polybar
# ---------------------------------------------
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config.ini (it will load [bar/main])
polybar main &

echo "Polybar launched..."
