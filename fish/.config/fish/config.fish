# Locale
set -gx LANG en_US.UTF-8

# Core paths
set -gx DOTFILES "$HOME/.dots"
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew's .NET is not in the default location, so tools installed with
# `dotnet tool` (and Mason's Roslyn server) need this to find the runtime
if test -d /opt/homebrew/opt/dotnet/libexec
    set -gx DOTNET_ROOT /opt/homebrew/opt/dotnet/libexec
end

# Disable greeting
set -g fish_greeting ""

# PATH (guard with existence checks to avoid dead entries)
# Lowest priority first: fish_add_path prepends, so the last one wins
set -l paths \
    $HOME/.docker/bin \
    $HOME/.dotnet/tools \
    $HOME/go/bin \
    $HOME/.cargo/bin \
    /opt/homebrew/bin \
    $HOME/.local/bin
for p in $paths
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
