# Exports
set -Ux DOTFILES $HOME/.dots
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux GOPATH $HOME/.go

# Disable greeting
set -U fish_greeting ""

# Paths
set -U fish_user_paths /opt/homebrew/opt/llvm/bin $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin /opt/homebrew/bin

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
test -r '/Users/gski/.opam/opam-init/init.fish' && source '/Users/gski/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

# Functions
function bbic
    brew update
    and brew bundle install --cleanup --file=~/.dots/brew/Brewfile --no-lock
    and brew upgrade
end

# Prompt
starship init fish | source
