# PATH

# add a path to PATH, but only if it's not already there
path_add() { # path_add [-a] PATH...
	# -a appends (default is prepend)
	APPEND=false
	if [ "x$1" = "x-a" ]; then
		APPEND=true
		shift
	fi

	for p; do
		case ":$PATH:" in
		*:"$p":*) ;;
		*)
			if $APPEND; then
				PATH="$PATH:$p"
			else
				PATH="$p:$PATH"
			fi
			;;
		esac
	done

	unset APPEND
}

path_add "$HOME/bin" "$HOME/usr/bin"

command -v luarocks >/dev/null 2>&1 && path_add "$HOME/.luarocks/bin"
