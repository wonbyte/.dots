# Exports (Universal Exported Variables)
set -Ux DOTFILES $HOME/.dots
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux GOPATH $HOME/.go

# Disable greeting (Universal Variable)
set -U fish_greeting ""

# Paths (Universal Variable)
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin /opt/homebrew/bin

# Set LLVM_PREFIX as a universal variable
set -U LLVM_PREFIX (brew --prefix llvm)

set -Ux LDFLAGS "-L$LLVM_PREFIX/lib"
set -Ux CPPFLAGS "-I$LLVM_PREFIX/include"
set -Ux CMAKE_PREFIX_PATH $LLVM_PREFIX
set -Ux CC "$LLVM_PREFIX/bin/clang"
set -Ux CXX "$LLVM_PREFIX/bin/clang++"

set -U fish_user_paths $fish_user_paths $LLVM_PREFIX/bin

# Aliases
abbr clr clear
abbr v nvim
abbr vi nvim
abbr vim nvim

# Prompt
starship init fish | source
