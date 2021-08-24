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
