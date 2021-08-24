# PLEASE
# if run without arguments, run the last command with 'sudo' (aka sudo !!)
# if run WITH arguments, alias as sudo

please() {
	history -d -1
	if [ -z "$1" ]; then
		#set --	$(HISTTIMEFORMAT=$'\t' history 2 | sed 's/^.*\t//;q')
		set -- $(fc -lnr | sed 1q)
	fi
	echo >&2 sudo "$@"
	history -s sudo "$@"
	"${DEBUG:-false}" || sudo "$@"
}
