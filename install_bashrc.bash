#!/bin/bash
set -e  # Exit on failed command

# Check the location of installation
DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}
echo dotfiles directory located at $DIRPATH
echo Installing dotfiles to $HOME with config to $CONFIGPATH.
read -p "Press enter to continue"

# Install dot files
cd $HOME
ln -sf $DIRPATH/src/core.bashrc .core.bashrc
[ -f $HOME/.bashrc ] || cp $DIRPATH/src/init.bashrc .bashrc
ln -sf $DIRPATH/src/core.bash_profile .core.bash_profile
[ -f $HOME/.bash_profile ] || cp $DIRPATH/src/init.bash_profile .bash_profile
ln -sf $DIRPATH/src/core.tmux.conf .tmux.conf

# Install config files
cd $CONFIGPATH
ln -sf $DIRPATH/src/.git-completion.bash
ln -sf $DIRPATH/src/.git-prompt.sh

source $HOME/.bashrc
