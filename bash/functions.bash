# Functions

memq() { # memq ITEM ARRAY
    # Test whether an ITEM is a member of ARRAY.
    # Pass ARRAY as ${ARRAY[@]}.
    local e needle="$1"; shift
    for e; do
        [[ "$e" == "$needle" ]] && {
            return 0
        }
    done
    return 1
}

please() { # please [COMMAND...]
	# if run without arguments, run the last command with 'sudo' (aka sudo !!)
	# if run WITH arguments, alias as sudo
	history -d -1
	if [ -z "$1" ]; then
		#set --	$(HISTTIMEFORMAT=$'\t' history 2 | sed 's/^.*\t//;q')
		set -- $(fc -lnr | sed 1q)
	fi
	echo >&2 sudo "$@"
	history -s sudo "$@"
	"${DEBUG:-false}" || sudo "$@"
}
