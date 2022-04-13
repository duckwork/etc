# shell-side configuration for Emacs vterm module
# https://github.com/akermu/emacs-libvterm#shell-side-configuration
# Make sure this is the last file loaded by ~/.bashrc!

# Load the requisite code from the vterm install directory
if [[ "$INSIDE_EMACS" = 'vterm' ]] \
       && [[ -n ${EMACS_VTERM_PATH} ]] \
       && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
	source ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh
fi

# Extra commands for `vterm-eval-cmds'

find_file() {
    vterm_cmd find-file "$(realpath "${@:-.}")"
}

say() {
    vterm_cmd message "%s" "$*"
}



