# $MANPATH shouldn't be too extra complicated (as opposed to $PATH),
# so I'm not going to include a whole other function.  AT SOME POINT,
# I suppose I should generalize that function to set /any/ path-type
# variable, not just $PATH.
# $MANPATH ends with `:' so that manpath(1) will prepend it to its
# special thing.

MANPATH="${XDG_DATA_HOME:-$HOME/.local/share}/man:"
export MANPATH
