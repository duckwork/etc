#!/bin/sh
# Bootstrap file for XDG_CONFIG_HOME
# by Case Duckworth <acdw@acdw.net>

### License:

# Everyone is permitted to do whatever with this software, without
# limitation.  This software comes without any warranty whatsoever,
# but with two pieces of advice:
# - Don't hurt yourself.
# - Make good choices.

### Commentary:

# For some time now, there has been a standard place to put configuration files
# for various programs: $XDG_CONFIG_HOME.  Slowly but surely, programs have
# been adapting to that standard for their configuration files, but there have
# been some stubborn holdouts.  Examples include shells such as sh, bash, and
# zsh.

# Luckily, the filesystem can help us.  This script takes input from a file in
# its $PWD, bootstrap.manifest, and reads linking directions from tab-delimited
# lines in that file.  Then, it creates links from within the cozy confines of
# $XDG_CONFIG_HOME to the wild west of ~, so that everyone is happy: you have
# your zen garden of configuration, and misbehaving programs have their bazaar.

### Code:

### Main entry point

main() {
    ## Sanity checking
    # Since bootstrap.sh does some naive path-mangling, let's show an error
    # if it's not run correctly.  Yes, there are other ways to run a
    # script.  But this script should ideally be run, like, one time.  Also
    # you can obviously comment this out or change it if you know what
    # you're doing!

    case "$0" in
        ./*) ;; # this is the way bootstrap.sh /should/ be run.
        *)
            printf >&2 'Weird invocation! %s\n' "$*"
            printf >&2 'Try: cd <bootstrap-dir>; ./bootstrap.sh\n'
            exit 127
            ;;
    esac

    ## Variables

    # option: -d/--dry-run
    : "${BOOTSTRAP_ACTION:=link}"
    # option: -v/--verbose
    : "${BOOTSTRAP_DEBUG:=false}"
    # option: -k/--keep-going
    : "${BOOTSTRAP_QUIT_ON_ERROR:=true}"
    # option: -m/--manifest FILE
    : "${BOOTSTRAP_MANIFEST_FILE:=bootstrap.manifest}"
    # option: -- (rest are passed to ln)
    : "${BOOTSTRAP_LN_ARGS:=-s}"

    ## Handle command-line flags
    # Basically an easier way of setting the above variables.
    while [ -n "$1" ]; do
        case "$1" in
            -h|--help)
                cat >&2 <<END_HELP
Usage: ./bootstrap.sh [-d] [-v] [-k] [-m FILE] [-f] [-- LN_OPTS]
OPTIONS:
    -d, --dry-run
        Only print what would happen.
    -v, --verbose
        Be more verbose about things.
    -k, --keep-going
        Keep going after an error.
    -f, --force
        Force linking.  Passes -f to ln.
    -m FILE, --manifest FILE
        Use FILE as manifest.
        Default: bootstrap.manifest.
    --	Signify end of options.  The rest are passed to ln.
END_HELP
                exit
                ;;
            -d|--dry-run)
                BOOTSTRAP_ACTION=print
                shift 1
                ;;
            -v|--verbose)
                BOOTSTRAP_DEBUG=true
                shift 1
                ;;
            -k|--keep-going)
                BOOTSTRAP_QUIT_ON_ERROR=false
                shift 1
                ;;
            -m|--manifest)
                case "$2" in
                    ''|-*)
                        printf >&2 "Bad argument: '$2'"
                        exit 129
                        ;;
                esac
                BOOTSTRAP_MANIFEST_FILE="$2"
                shift 2
                ;;
            -f|--force)
                BOOTSTRAP_LN_ARGS="$BOOTSTRAP_LN_ARGS -f"
                shift 1
                ;;
            --)
                shift 1
                BOOTSTRAP_LN_ARGS="$@"
                break
                ;;
        esac
    done

    ## Main loop
    while IFS='	' read -r source destination; do
        # Ignore lines beginning with '#'
        case "$source" in
            '#'*)
                if "$BOOTSTRAP_DEBUG"; then
                    printf >&2 'Skipping comment: %s %s\n' \
                           "$source" "$destination"
                fi
                continue
                ;;
        esac

        # Ignore empty lines, or lines with only SOURCE or DESTINATION
        if [ -z "$source" ] || [ -z "$destination" ]; then
            if "$BOOTSTRAP_DEBUG"; then
                printf >&2 'Skipping line: %s\t%s\n' \
                       "$source" "$destination"
            fi
            continue
        fi

        # Do the thing
        if ! dispatch "$source" "$destination"; then
            printf >&2 'ERROR: %s -> %s\n' \
                   "$source" "$destination"
            if "$BOOTSTRAP_QUIT_ON_ERROR"; then
                exit "$dispatch_error"
            fi
        fi
    done < "$BOOTSTRAP_MANIFEST_FILE"
}

### Functions

dispatch() { # dispatch SOURCE DESTINATION
    # Depending on environment variables, do the linking or displaying or
    # whatever of a source and a destination.

    ## Variables

    src="$1"
    dest="$2"
    dispatch_error=0		# success

    ## Sanitize pathnames

    # If the SOURCE starts with ~, /, or $, keep it as-is; otherwise,
    # prepend "$PWD/".
    case "$src" in
        '/'* | '~'* | '$'* ) ;;
        *) src="$PWD/$src" ;;
    esac

    # Convert ~ to $HOME in SOURCE and DESTINATION, to get around shell
    # quoting rules.
    src="$(printf '%s\n' "$src" | sed "s#^~#$HOME#")"
    dest="$(printf '%s\n' "$dest" | sed "s#^~#$HOME#")"

    ## Do the thing

    # /Always/ tell the user what we're doing.
    if [ -f "$dest" ]; then
        printf >&2 'mv %s %s.old\n' "$dest" "$dest"
    fi
    printf >&2 "ln %s %s %s\n" "$BOOTSTRAP_LN_ARGS" "$src" "$dest"

    case "$BOOTSTRAP_ACTION" in
        link) # actually ... do the links
            # if DESTINATION exists, move it to DESTINATION.old
            if [ -f "$dest" ]; then
                mv "$dest" "$dest.old"
            fi

            ln $BOOTSTRAP_LN_ARGS "$src" "$dest" ||
                dispatch_error="$?"
            ;;
        print) ;; # already printed.
    esac

    return "$dispatch_error"
}

### Do the thing

main "$@"
