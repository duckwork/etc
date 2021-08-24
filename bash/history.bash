# Bash history settings
# I don't export any variables in this file because history settings 
# really only apply in an interactive session.

# XDG compliance
HISTFILE="$XDG_DATA_HOME/bash/history"
mkdir -p "$XDG_DATA_HOME/bash"

# Don't truncate history
HISTFILESIZE=-1 # numeric values less than zero => don't truncate
HISTSIZE=100000 # ideally, I wouldn't truncate at all, but after a while shell
# startup might be affected.

# Append the history to HISTFILE.
shopt -s histappend

# History editing with readline
shopt -s histreedit # allow re-editing of a failed history substitution
shopt -s histverify # verify a history expansion before running it

# Save command invocation time to HISTFILE, and format it thusly
HISTTIMEFORMAT="%F %T "

# Erase all duplicates before saving the current line
HISTCONTROL=erasedups
# Don't save some commands to history
# "'HISTIGNORE' subsumes the function of 'HISTCONTROL'.  A pattern of
# '&' is identical to 'ignoredups', and a pattern of '[ ]*' is
# identical to 'ignorespace'." -- info (bash)Bash Variables
HISTIGNORE='&:[ ]*'
# Other commands to ignore
HISTIGNORE="$HISTIGNORE:ls:exit:cd"

# Automatically append to HISTFILE on every command
PROMPT_COMMAND="history -a; ${PROMPT_COMMAND:-:}"
