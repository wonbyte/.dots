# https://github.com/ThePrimeagen/.dotfiles/blob/master/install
export STOW_FOLDERS="bin,fish,kitty,nvim,tmux"

pushd $HOME/.dotfiles

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done

popd
