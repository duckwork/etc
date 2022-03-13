# start the ssh-agent

# use keychain(1), if available
if type keychain > /dev/null 2>&1; then
    # Save directory name in a variable (for ease of maintenance)
    export KEYCHAIN_HOME="$HOME/.keychain"
    eval $(keychain --eval --dir "$KEYCHAIN_HOME" --agents ssh 2>/dev/null)
else
    eval $(ssh-agent -s)
fi
