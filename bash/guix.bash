export GUIX_PROFILE="$HOME/.config/guix/current"

[ -r "$GUIX_PROFILE/etc/profile" ] && 
	. "$GUIX_PROFILE/etc/profile"
