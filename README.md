## .dots

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

### Install

```sh
git clone https://github.com/wonbyte/.dots ~/.dots
cd ~/.dots
brew bundle --file brew/Brewfile
./install.sh
```

### Structure

| Directory | Config |
|-----------|--------|
| `bin` | Scripts (`~/.local/bin`) |
| `fish` | Fish shell |
| `ghostty` | Ghostty terminal |
| `nvim` | Neovim |
| `starship` | Starship prompt |
| `tmux` | tmux |
