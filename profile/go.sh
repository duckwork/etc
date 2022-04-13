export GOPATH="${XDG_DATA_HOME:=$HOME/.local/share}/go"
command -v go >/dev/null 2>&1 && path_add_to_PATH "$(go env GOPATH)/bin"
