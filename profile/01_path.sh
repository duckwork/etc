# PATH

# see 00_functions.sh for `path_add'
path_add_to_PATH "$HOME/bin" "$HOME/usr/bin"

command -v luarocks >/dev/null 2>&1 && path_add "$HOME/.luarocks/bin"
