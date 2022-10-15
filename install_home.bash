#!/bin/bash
set -e  # Exit on failed command

# Check the location of installation
DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}
echo dotfiles directory located at $DIRPATH
echo Installing dotfiles and configs to $HOME and $CONFIGPATH.
([ "$1" == "-n" ] && shift) || read -p "Press enter to continue"

# Install dot files
cd $HOME
ln -sf $DIRPATH/src/core.bashrc .core.bashrc
([ -f $HOME/.bashrc ] && echo found .bashrc, skip installing it) || cp $DIRPATH/src/init.bashrc .bashrc
ln -sf $DIRPATH/src/core.bash_profile .core.bash_profile
([ -f $HOME/.bash_profile ] && echo found .bashrc_profile, skip installing it) || cp $DIRPATH/src/init.bash_profile .bash_profile
ln -sf $DIRPATH/src/core.tmux.conf .tmux.conf

# Install config files
mkdir -p $CONFIGPATH
cd $CONFIGPATH
ln -sf $DIRPATH/src/.git-completion.bash
ln -sf $DIRPATH/src/.git-prompt.sh

source $HOME/.bashrc

# Install neovim
([ -d $HOME/nvim-python3 ] && echo found .nvim-python3, skip installing it) || (
    python3 -m venv ~/nvim-python3 &&
    . ~/nvim-python3/bin/activate &&
    pip3 install pynvim neovim neovim-remote &&
    deactivate
)
PLUGFILE=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
([ -f "$PLUGFILE" ] && echo "found $PLUGFILE, skip installing it") || curl -fLo $PLUGFILE --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd $CONFIGPATH
([ -f $CONFIGPATH/nvim ] && echo "found $CONFIGPATH/nvim, skip installing it") || (
    ln -sf $DIRPATH/src/nvim &&
    nvim --headless +PlugUpdate +qall
)

# Install pipx
python3 -m pip install --user pipx && python3 -m pipx ensurepath

# Install poetry
which poetry || pipx install poetry

if [ "$1" == "-p" ]; then
    # Install pyenv
    ([ -d $HOME/.pyenv ] && echo found .pyenv, skip installing it) || git clone git://github.com/yyuu/pyenv.git ~/.pyenv
fi
