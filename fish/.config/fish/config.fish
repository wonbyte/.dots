# Exports
set -gx DOTFILES $HOME/.dots
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx GOPATH $HOME/.go

# Disable greeting
set fish_greeting ""

# Paths
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin /opt/homebrew/bin

# Aliases
abbr clr clear
abbr v nvim
abbr vi nvim
abbr vim nvim

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/gps/.opam/opam-init/init.fish' && source '/Users/gps/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

# Prompt
starship init fish | source
