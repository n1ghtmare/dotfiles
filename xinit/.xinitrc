#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Disable screen saver
xset s off
# Disable DPMS (Energy Star) features
xset -dpms
# Disable screen blanking
xset s noblank

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Remap Keys
# Make Caps Lock an additional Esc and both Shift Keys toggle Caps Lock
# setxkbmap -option caps:escape,shift:both_capslock &

# Persist xrandr settings to use 144Hz 4k
xrandr --output DP-2 --mode 3840x2160 --rate 144

# Have both US and Bulgarian layouts (switch by pressing right shift and right alt)
setxkbmap -layout us,bg -variant ,phonetic -option grp:ralt_rshift_toggle

# Start the window manager (BSPWM)
exec bspwm
