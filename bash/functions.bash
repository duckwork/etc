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
