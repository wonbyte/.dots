# Exports
set -Ux DOTFILES $HOME/.dots
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux GOPATH $HOME/.go

# Disable greeting
set -U fish_greeting ""

# Paths
set -U fish_user_paths /opt/homebrew/opt/llvm/bin $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin $HOME/.dune/bin /opt/homebrew/bin

# Aliases
abbr clr clear
abbr v nvim
abbr vi nvim
abbr vim nvim

# Functions
function bbic
    brew update
    and brew bundle install --cleanup --file=~/.dots/brew/Brewfile --no-lock
    and brew upgrade
end

# Prompt
starship init fish | source

# dune
set --export PATH /Users/gski/.dune/bin $PATH
