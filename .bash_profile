# .bash_profile

# User specific environment and startup programs

unset SSH_ASKPASS
unset LD_LIBRARY_PATH

user_paths=$HOME/.local/bin
global_paths=/usr/local/MATLAB/R2010b/bin:/opt/torque/bin
system_paths=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

export PATH=$user_paths:$global_paths:$system_paths
# export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
# export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH


# Get the aliases and functions
if [ -f $HOME/.bashrc ]
then
	source $HOME/.bashrc
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# eval "$(pyenv virtualenv-init -)"

export PATH="$HOME/.cargo/bin:$PATH"
