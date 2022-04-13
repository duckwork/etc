# See 00_functions.sh for `path_add_unsafe'.

path_add_unsafe INFOPATH \
                /usr/share/info \
                "${XDG_DATA_HOME:-$HOME/.local/share}/info"

export INFOPATH
