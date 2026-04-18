# Locale
set -gx LANG en_US.UTF-8

# Core paths
set -gx DOTFILES "$HOME/.dots"

# Toolchain flags (only if LLVM exists)
if test -d /opt/homebrew/opt/llvm
    set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
    set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
end

# Disable greeting
set -g fish_greeting ""

# PATH (guard with existence checks to avoid dead entries)
for p in /opt/homebrew/opt/llvm/bin $HOME/.local/bin /opt/homebrew/bin $HOME/.cargo/bin
    if test -d $p
        fish_add_path -g $p
    end
end

# Aliases (abbr in fish)
abbr -a clr clear
abbr -a v nvim
abbr -a vi nvim
abbr -a vim nvim

# Prompt (only in interactive shell)
if status is-interactive
    starship init fish | source
end
