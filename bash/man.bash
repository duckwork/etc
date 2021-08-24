export MANWIDTH=80

# on smaller terminals, use their width
# (cf. https://wiki.archlinux.org/index.php/Man_page#Page_width)
man() {
	local width=$(tput cols)
	[ $width -gt $MANWIDTH ] && width=$MANWIDTH
	env MANWIDTH=$width man "$@"
}
