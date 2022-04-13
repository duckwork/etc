# Functions

memq() { # memq ITEM ARRAY
    ## Test whether an ITEM is a member of ARRAY.
    ## Pass ARRAY as ${ARRAY[@]}.
    local e needle="$1"; shift
    for e; do
        [[ "$e" == "$needle" ]] && {
            return 0
        }
    done
    return 1
}

rebashrc() { # rebashrc
    ## Reload ~/.bashrc
    printf "Loading ~/.bashrc..." >&2
    if source "$HOME/.bashrc"; then
        echo "OK." >&2
    else
        echo "ERROR!" >&2
    fi
}

first_which() { # first_which COMMAND...
    ## Return the fully-qualified path of the first COMMAND found in $PATH.
    while :; do
        command -v "$1" && break
        [ -z "$1" ] && return 1
        shift
    done
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
