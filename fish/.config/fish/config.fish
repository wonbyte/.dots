# Exports
set -gx DOTFILES $HOME/.dots
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx GOPATH $HOME/.go
# LLVM
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# Disable greeting
set fish_greeting ""

# Paths
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin

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
