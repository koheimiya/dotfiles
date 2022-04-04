#!/bin/bash
set -e  # Exit on failed command

# Check the location of installation
DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)
        machine=Linux
        install='sudo apt install -y'
        update='sudo apt update'
        ;;
    Darwin*)
        machine=Mac
        install='brew install'
        update='brew update'
        ;;
    *)
        echo Unsupported uname: ${unameOut}
        exit 1
esac
echo OS detected: $machine
echo dotfiles directory located at $DIRPATH
echo Installing dotfiles to nodejs, pyenv, poetry and neovim.
read -p "Press enter to continue"

# check prerequisite and update package manager
which git || (echo Install git && exit 1)
which curl || (echo Install curl && exit 1)
eval $update
eval "$install bash-completion"

# Install Nodejs
case $machine in
    Linux)
        which node || (
            sudo apt install -y nodejs npm &&
            sudo npm install n -g &&
            sudo n stable &&
            sudo apt purge -y nodejs npm
        )
        ;;
    Mac)
        which node || brew install node
        ;;
    *)
        echo Unsupported machine: $machine
        exit 1
esac

# Install pyenv
[ -d $HOME/.pyenv ] || git clone git://github.com/yyuu/pyenv.git ~/.pyenv

# Install python3 and build dependencies
case $machine in
    Linux)
        sudo apt install -y python3-venv python3-pip
        sudo apt install -y git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev
        python3 -m pip install --user pipx && python3 -m pipx ensurepath
        ;;
    Mac)
        which python3 || brew install python3
        brew install pipx && pipx ensurepath
        ;;
    *)
        echo Unsupported machine: $machine
        exit 1
esac

# Install poetry
which poetry || (
    (curl -sSL https://install.python-poetry.org | python3 - ) &&
    poetry config virtualenvs.in-project true
)

# Install neovim
which nvim || eval "$install neovim"
[ -d $HOME/nvim-python3 ] || (
    python3 -m venv ~/nvim-python3 &&
    . ~/nvim-python3/bin/activate &&
    pip3 install pynvim neovim neovim-remote &&
    deactivate
)
PLUGFILE=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
[ -f "$PLUGFILE" ] || curl -fLo $PLUGFILE --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd $CONFIGPATH
ln -sf $DIRPATH/src/nvim
nvim --headless +PlugUpdate +qall
