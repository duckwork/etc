# XDG compliance (miscellaneous)

# If an XDG-complaint variable makes more sense somewhere else, it'll be
# moved there (e.g., HISTFILE is in history.bash).  So variables might
# move /out/ of this directory, but they probably won't move /in/.

# Readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
mkdir -p "$XDG_CACHE_HOME"/less

# Vim
export VIMINIT="source ${XDG_CONFIG_HOME:=$HOME/.config}/vim/vimrc"

# Weechat
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

# Lynx
export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"

# Xorg
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME}"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"

# Notmuch
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:=$HOME/.config}/notmuch/config"
