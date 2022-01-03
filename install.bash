#!/bin/bash
which nvim || ( sudo apt update && sudo apt install neovim ) || exit 1


DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo dotfiles directory located at $DIRPATH
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}
SRCPATH=$CONFIGPATH/dotfiles

[ "$SRCPATH" == "$DIRPATH" ] || (
    echo dotfiles location does not match install location. &&
    echo Installing to $CONFIGPATH &&
    mkdir -f $CONFIGPATH &&
    cd $CONFIGPATH &&
    ln -s $DIRPATH $SRCPATH
)

# Install dot files
cd $HOME
ln -s $SRCPATH/.bashrc
ln -s $SRCPATH/.bash_profile
ln -s $SRCPATH/.tmux.conf
source .bashrc

# Install pyenv
[ -d $HOME/.pyenv ] || git clone git://github.com/yyuu/pyenv.git ~/.pyenv

# Install virtual env for neovim
( sudo apt update && sudo apt install python3-venv python3-pip ) || exit 1
[ -d $HOME/nvim-python3 ] || (
    python3 -m venv ~/nvim-python3 &&
    source ~/nvim-python3/bin/activate &&
    pip install pynvim neovim &&
    deactivate
)

# Install neovim configs
cd $CONFIGPATH
PLUGFILE=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
[ -f "$PLUGFILE" ] || sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s dotfiles/nvim
nvim --headless +PlugUpdate +qall
