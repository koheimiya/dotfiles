#!/bin/bash
set -e  # Exit on failed command

# Check the location of installation
DIRPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}
echo dotfiles directory located at $DIRPATH
echo Installing dotfiles and configs to $HOME and $CONFIGPATH.
([[ "$1" == "-n" ]] && shift) || read -p "Press enter to continue"

# Install dot files
case $SHELL in
*/zsh)
    # assume Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rcfile=.zshrc
    profilefile=.zprofile
   ;;
*/bash)
   # assume Bash
   rcfile=.bashrc
   profilefile=.bash_profile
   ;;
*)
    echo Shell $SHELL not supported.
    exit 1
esac
cd $HOME
ln -sf $DIRPATH/src/core.bashrc .core.bashrc
([[ -f $HOME/$rcfile ]] && echo found $rcfile, skip installing it) || cp $DIRPATH/src/init.bashrc $rcfile # .bashrc
ln -sf $DIRPATH/src/core.bash_profile .core.bash_profile
([[ -f $HOME/$profilefile ]] && echo found $profilefile, skip installing it) || cp $DIRPATH/src/init.bash_profile $profilefile  # .bash_profile
ln -sf $DIRPATH/src/core.tmux.conf .tmux.conf

# Install config files
mkdir -p $CONFIGPATH
cd $CONFIGPATH
ln -sf $DIRPATH/src/.git-completion.bash
ln -sf $DIRPATH/src/.git-prompt.sh

source $HOME/$rcfile

# Install neovim peripherals
([[ -d $HOME/nvim-python3 ]] && echo found .nvim-python3, skip installing it) || (
    python3 -m venv ~/nvim-python3 &&
    . ~/nvim-python3/bin/activate &&
    pip3 install pynvim neovim neovim-remote &&
    deactivate
)
PLUGFILE=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
([[ -f "$PLUGFILE" ]] && echo "found $PLUGFILE, skip installing it") || curl -fLo $PLUGFILE --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd $CONFIGPATH
([[ -f $CONFIGPATH/nvim ]] && echo "found $CONFIGPATH/nvim, skip installing it") || (
    ln -sf $DIRPATH/src/nvim &&
    nvim --headless +PlugUpdate +qall
)

# Install pipx
python3 -m pip install --user pipx && python3 -m pipx ensurepath

# Install pdm
which pdm || pipx install pdm

# if [[ "$1" == "-p" ]]; then
#     # Install pyenv
#     ([[ -d $HOME/.pyenv ]] && echo found .pyenv, skip installing it) || curl https://pyenv.run | bash
# fi
