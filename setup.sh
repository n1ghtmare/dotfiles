#!/bin/bash

echo 'Setting up the configs'

if [ ! -e '~/.config/bspwm/bspwmrc' ]; then
	echo "BSPWM directory doesn't exist will create"
fi
