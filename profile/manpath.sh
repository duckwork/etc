# See 00_functions.sh for `path_add_unsafe'.

path_add_unsafe MANPATH \
                "${XDG_DATA_HOME:-$HOME/.local/share}/man" \
                "$HOME/.local/local/man" \
                "$HOME/usr/local/man"

# $MANPATH ends with `:' so that manpath(1) will prepend it to its
# special thing.
case "$MANPATH" in
    *:) ;;
    *) MANPATH="$MANPATH:" ;;
esac

export MANPATH
