# Clean up stale universal variables from previous config
set -eU DOTFILES
set -eU LANG
set -eU LC_ALL
set -eU GOPATH
set -eU fish_greeting
set -eU fish_user_paths

# Exports
set -gx DOTFILES $HOME/.dots
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx GOPATH $HOME/.go

set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# Disable greeting
set -g fish_greeting ""

# Paths
fish_add_path -g /opt/homebrew/opt/llvm/bin $HOME/.local/bin /opt/homebrew/bin $HOME/.cargo/bin $GOPATH/bin

# Aliases
abbr clr clear
abbr v nvim
abbr vi nvim
abbr vim nvim

# Prompt
starship init fish | source
