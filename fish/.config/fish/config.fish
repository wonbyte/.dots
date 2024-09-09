# Exports
set -gx DOTFILES $HOME/.dots
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx GOPATH $HOME/.go

# Disable greeting
set fish_greeting ""

# Paths
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin /opt/homebrew/bin /opt/homebrew/opt/llvm/bin/

# Aliases
abbr clr clear
abbr v nvim
abbr vi nvim
abbr vim nvim

# Prompt
starship init fish | source
