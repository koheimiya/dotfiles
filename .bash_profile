# .bash_profile

# Avoid GUI interruption on SSH authentication
unset SSH_ASKPASS

# Get the aliases and functions
if [ -f $HOME/.bashrc ]
then
	source $HOME/.bashrc
fi
