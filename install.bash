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
echo Installing dotfiles to $HOME, nodejs, pyenv, poetry and neovim, with config to $CONFIGPATH.
read -p "Press enter to continue"

# Install Bash completion
case $machine in
    Linux)
        echo Installation of Bash completion is skipped. May be you want to install it manually.
        ;;
    Mac)
        brew install bash-completion
        ;;
    *)
        echo Unsupported machine: $machine
        exit 1
esac


# Install dot files
cd $HOME
ln -sf $DIRPATH/src/.bashrc
ln -sf $DIRPATH/src/.bash_profile
ln -sf $DIRPATH/src/.tmux.conf

# Install config files
cd $CONFIGPATH
ln -sf $DIRPATH/src/.git-completion.bash
ln -sf $DIRPATH/src/.git-prompt.sh

# check prerequisite and update package manager
which git || (echo Install git && exit 1)
which curl || (echo Install curl && exit 1)
eval $update

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

# Install python3 and virtual env for neovim
case $machine in
    Linux)
        sudo apt install -y python3-venv python3-pip
        ;;
    Mac)
        which python3 || brew install python3
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
    source ~/nvim-python3/bin/activate &&
    pip install pynvim neovim &&
    deactivate
) || exit 1
PLUGFILE=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
[ -f "$PLUGFILE" ] || sh -c 'curl -fLo "$PLUGFILE" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cd $CONFIGPATH
ln -sf $DIRPATH/src/nvim
nvim --headless +PlugUpdate +qall
