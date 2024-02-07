# https://github.com/ThePrimeagen/.dotfiles/blob/master/install
export STOW_FOLDERS="bin,fish,kitty,nvim,tmux"

pushd $HOME/.dots

for folder in $(echo $STOW_FOLDERS | /usr/bin/sed "s/,/ /g")
do
    /opt/homebrew/bin/stow -D $folder
    /opt/homebrew/bin/stow $folder
done
