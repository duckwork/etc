# Bash aliases

# sudo
sudo_cmds=(
    shutdown
    reboot
    halt
    mount
    umount
    visudo
)
for cmd in "${sudo_cmds[@]}"; do
    alias $cmd="sudo $cmd"
done

# LS
alias ls='ls -F --color=auto'
alias ll='ls -l'
# tree
alias tree='tree -F'

# make locally
alias lake='make PREFIX=~/usr'

# bash meta
alias rebash='source ~/.bash_profile'
