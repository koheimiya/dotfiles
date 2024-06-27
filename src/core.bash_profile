# .bash_profile

# status colors
red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
reset="\[$(tput sgr0)\]"

# completion
case $SHELL in
*/bash)
    bind '"\e[A": history-search-backward'
    bind '"\e[0A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[0B": history-search-forward'
   ;;
esac

# Avoid GUI interruption on SSH authentication
unset SSH_ASKPASS

# Get the aliases and functions
if [[ -f $HOME/.bashrc ]]
then
	source $HOME/.bashrc
fi

[[ -d $HOME/.pyenv ]] && "$(pyenv init --path)"
