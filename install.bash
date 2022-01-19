#!/bin/bash
sudo apt update
DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}
echo dotfiles directory located at $DIRPATH
echo installing config to $CONFIGPATH

# Install dot files
cd $HOME
ln -sf $DIRPATH/src/.bashrc
ln -sf $DIRPATH/src/.bash_profile
ln -sf $DIRPATH/src/.tmux.conf

# Install config files
cd $CONFIGPATH
ln -sf $DIRPATH/src/.git-completion.bash
ln -sf $DIRPATH/src/.git-prompt.sh

# Install Nodejs
which node || (
    sudo apt install -y nodejs npm &&
    sudo npm install n -g &&
    sudo n stable &&
    sudo apt purge -y nodejs npm
) || exit 1

# Install pyenv
[ -d $HOME/.pyenv ] || git clone git://github.com/yyuu/pyenv.git ~/.pyenv || exit 1

# Install poetry
which poetry || ( curl -sSL https://install.python-poetry.org | python3 - ) || exit 1
poetry config virtualenvs.in-project true || exit 1

# Install virtual env for neovim
sudo apt install -y python3-venv python3-pip || exit 1
[ -d $HOME/nvim-python3 ] || (
    python3 -m venv ~/nvim-python3 &&
    source ~/nvim-python3/bin/activate &&
    pip install pynvim neovim &&
    deactivate
) || exit 1

# Install neovim
which nvim || sudo apt install -y neovim || exit 1
cd $CONFIGPATH
PLUGFILE=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
[ -f "$PLUGFILE" ] || sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -sf $DIRPATH/src/nvim
nvim --headless +PlugUpdate +qall
