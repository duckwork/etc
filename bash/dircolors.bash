DIRCOLORS="${XDG_CONFIG_HOME:-$HOME/.config/dircolors}"

if [ -f "$DIRCOLORS" ]; then
    eval $(dircolors --sh "$DIRCOLORS");
fi
