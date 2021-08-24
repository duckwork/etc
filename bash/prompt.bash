# bash prompt

PS1=

# user, host, and cwd
PROMPT_DIRTRIM=3 # how many dirs above current to print (rest are '...')
PS1+='\[\e[36m\]\u@\h \w'

# git bit
source /usr/share/git/git-prompt.sh &&
    PS1+='\[\e[35m\]$(__git_ps1)'

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
