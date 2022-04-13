# utility functions for all shells
# these should be POSIX-compatible.

# add a path to PATH, but only if it's not already there
path_add_to_PATH() { # path_add [-a] PATH...
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

# Generalization of `path_add_to_PATH' for any variable.
path_add_unsafe() { #path_add_unsafe [-a] [-d DELIM] VAR PATH...
    ## Add PATH... to VAR, delimiting with DELIM (default :).
    # By default, the VAR will be prepended to; passing -a will append the
    # variable.  -d DELIM defines the delimiter.
    #
    # This function has the _unsafe suffix because it uses `eval' to set
    # variables.
    APPEND=false; DELIM=:
    while getopts ad: opt; do
        case "$opt" in
            a) APPEND=true ;;
            d) DELIM="$OPTARG" ;;
            *) return 1 ;;
        esac
    done
    shift $(expr $OPTIND - 1)

    var="$1"; shift

    for path; do
        case ":$(eval "echo \$$var"):" in
            *:"$path":*) ;;
            *)
                if $APPEND; then
                    eval "$var=\$$var${var:+$DELIM}$path"
                else
                    eval "$var=$path${var:+$DELIM}\$$var"
                fi
                ;;
        esac
    done
    unset -v APPEND DELIM var
}
