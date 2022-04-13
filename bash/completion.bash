# Completions.bash
# Source bash completion libraries

POSSIBLE_COMPLETION_FILES=(
    /etc/bash_completion # Debian
    /etc/profile.d/bash_completion.sh # Alpine
    # I'm sure there are many more
)

for candidate in "${POSSIBLE_COMPLETION_FILES[@]}"; do
    if [[ -r "$candidate" ]]; then
        source "$candidate"
        break # XXX: Do I want this?
    fi
done
