## .dots

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

### Install

```sh
git clone https://github.com/wonbyte/.dots ~/.dots
cd ~/.dots
brew bundle --file brew/Brewfile
./install.sh
```

### Fish as the login shell

One time, on a new Mac:

```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

### Neovim tools

Language servers come from [Mason](https://github.com/mason-org/mason.nvim), not
Homebrew. Neovim installs the missing ones by itself on start (see
`nvim/.config/nvim/lua/plugins/mason.lua`).

`prettier` is per repo (`npm install --save-dev prettier`). Neovim uses the copy in
`node_modules` when it exists.

TypeScript is per repo too: the `tsgo` server runs the TypeScript 7+ (`tsc --lsp`)
or `tsgo` binary from the repo's `node_modules`.

Plugins and parsers install by themselves on first start. They need `make` and a
C compiler (`xcode-select --install`).

Not installed by this repo:

- Node.js and `npm`, for `tsgo` and `prettier`.
- Rust from [rustup](https://rustup.rs), for `rust-analyzer` and `rustfmt`.

### Structure

| Directory | Config |
|-----------|--------|
| `bin` | Scripts (`~/.local/bin`) |
| `fish` | Fish shell |
| `ghostty` | Ghostty terminal |
| `nvim` | Neovim |
| `starship` | Starship prompt |
| `tmux` | tmux |
