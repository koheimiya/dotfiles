#!/bin/bash
which nvim || ( sudo apt update && sudo apt install -y neovim ) || exit 1


DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo dotfiles directory located at $DIRPATH
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}

# Install dot files
cd $HOME
ln -sf $DIRPATH/src/.bashrc
ln -sf $DIRPATH/src/.bash_profile
ln -sf $DIRPATH/src/.tmux.conf

# Install config files
cd $CONFIGPATH
ln -sf $DIRPATH/src/.git-completion.bash
ln -sf $DIRPATH/src/.git-prompt.sh

# Install pyenv
[ -d $HOME/.pyenv ] || git clone git://github.com/yyuu/pyenv.git ~/.pyenv

# Install poetry
which poetry || ( curl -sSL https://install.python-poetry.org | python3 - )
poetry config virtualenvs.in-project true

# Install virtual env for neovim
( sudo apt update && sudo apt install -y python3-venv python3-pip ) || exit 1
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
ln -sf $DIRPATH/src/nvim

