# bash prompt

PS1=

# user, host, and cwd
PROMPT_DIRTRIM=3 # how many dirs above current to print (rest are '...')
PS1+='\[\e[0;46m\]\u@\h \w'

# git bit
# see https://unix.stackexchange.com/questions/278206
possible_git_prompt_locations=(
    /usr/share/git/git-prompt.sh # Arch, etc. (default?)
    /usr/lib/git-core/git-sh-prompt # Debian, Ubuntu ...
    /usr/share/git-core/contrib/completion/git-prompt.sh # Fedora ??
    # I have yet to find Alpine's git prompt location.
)

for file in "${possible_git_prompt_locations[@]}"; do
        if [[ -f "$file" ]]; then
                source "$file" &&
                        PS1+='\[\e[35m\]$(__git_ps1)'
                break
        fi
done

# newline
PS1+='\[\e[0m\]\n'

# exit code (only if error)
__prompt_exit_code() {
        local ec=$?
        (( $ec > 0 )) &&
                printf "$ec"
}
PS1+='\[\e[31m\]$(__prompt_exit_code)\[\e[0m\]'

# delimiter
PS1+='; '
