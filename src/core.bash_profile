# .bash_profile

# status colors
red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
reset="\[$(tput sgr0)\]"

# completion
bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'

# Avoid GUI interruption on SSH authentication
unset SSH_ASKPASS

# Get the aliases and functions
if [ -f $HOME/.bashrc ]
then
	source $HOME/.bashrc
fi

eval "$(pyenv init --path)"
