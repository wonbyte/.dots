#!/usr/bin/env bash
set -euo pipefail

# Folders to stow. The brew/ folder is intentionally excluded —
# Brewfiles don't need symlinking; run: brew bundle --file brew/Brewfile
STOW_FOLDERS=(bin fish ghostty nvim starship tmux)

# Stow from wherever this repo was cloned
DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command -v stow >/dev/null || {
    echo "Error: stow is not installed. Run: brew bundle --file brew/Brewfile" >&2
    exit 1
}

# Create real directories first so stow links their contents instead of
# folding the whole directory into the repo. Other tools write here
# (for example fish -> ~/.config/fish) and must not land in git.
mkdir -p "${HOME}/.local/bin" "${HOME}/.config/fish"

for folder in "${STOW_FOLDERS[@]}"; do
    if [[ ! -d "${DOTS_DIR}/${folder}" ]]; then
        echo "Warning: Folder '${folder}' does not exist in ${DOTS_DIR}. Skipping." >&2
        continue
    fi

    # -R unstows then stows, so stale links are pruned in one pass.
    # Finder drops .DS_Store files anywhere; never link those into $HOME.
    if ! stow -d "$DOTS_DIR" -t "$HOME" --ignore='\.DS_Store' -R "$folder"; then
        echo "Error: Failed to stow folder '${folder}'." >&2
        exit 1
    fi
done

echo "Stow operations completed successfully."
