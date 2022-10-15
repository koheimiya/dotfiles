#!/bin/bash
set -e  # Exit on failed command

# Check the location of installation
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)
        machine=Linux
        install='apt install -y'
        update='apt update'
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
echo Installing nodejs, python and neovim.
[ "$1" == "-n" ] || read -p "Press enter to continue"

# Update package manager
eval $update

# Install bash-completion
eval "$install bash-completion"

# Install special packages: git and curl
case $machine in
    Linux)
        which git || eval "$install git"
        which curl || eval "$install curl"
        ;;
    Mac)
        which git || (echo Please manually install git first. && exit 1)
        which curl || (echo Please manually install curl first. && exit 1)
        ;;
esac

# Install Nodejs
case $machine in
    Linux)
        which node || (
            apt install -y nodejs npm &&
            npm install n -g &&
            n stable &&
            apt purge -y nodejs npm
        )
        ;;
    Mac)
        which node || brew install node
        ;;
esac

# Install python3 and its build dependencies
case $machine in
    Linux)
        apt install -y python3-venv python3-pip
        apt install -y git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev
        ;;
    Mac)
        which python3 || brew install python3
        ;;
esac

# Install neovim
case $machine in
    Linux)
        which nvim || (
            eval "$install software-properties-common" &&
            add-apt-repository ppa:neovim-ppa/stable
        )
        ;;
esac
which nvim || eval "$install neovim"
