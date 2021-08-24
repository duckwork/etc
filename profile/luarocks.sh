# add luarocks stuff to $PATH

command -v luarocks >/dev/null 2>&1 &&
	eval $(luarocks path)
