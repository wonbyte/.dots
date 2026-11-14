# Locale
set -gx LANG en_US.UTF-8

# Core paths
set -gx DOTFILES "$HOME/.dots"
set -gx EDITOR nvim
set -gx VISUAL nvim

# Disable greeting
set -g fish_greeting ""

# PATH (guard with existence checks to avoid dead entries)
# Reversed: fish_add_path prepends, so last added wins
for p in $HOME/go/bin $HOME/.cargo/bin /opt/homebrew/bin $HOME/.local/bin
    if test -d $p
        fish_add_path -g $p
    end
end

if status is-interactive
    # Aliases (abbr in fish)
    abbr -a clr clear
    abbr -a v nvim
    abbr -a vi nvim
    abbr -a vim nvim

    # Prompt
    if command -q starship
        starship init fish | source
    end
end
