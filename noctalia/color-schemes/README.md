This is a bit of a hack, but I'm too lazy to create a full Noctalia theme and
push it upstream as an official theme (it involves creating themes for ghostty,
kitty and foot terminals, also creating light themes for Noirbuddy Oxide for
all of those).

So instead, I've created a simple JSON file that only includes the theme for
the shell (not the terminals, so this won't work with matugen).

To enable the theme, cd into:
`/etc/xdg/quickshell/noctalia-shell/Assets/ColorScheme`, copy any of the color
scheme folders and rename it to `Noirbuddy-Oxide`, then copy the
`Noirbuddy-Oxide.json` file from this repo into that folder, replacing the
existing one.

To copy the Noctalia settings, copy the `settings.json` file from this repo
into `~/.config/noctalia/`, replacing the existing one.


