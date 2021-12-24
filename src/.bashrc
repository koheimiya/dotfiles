# .bashrc

# Check if intaractive
if [[ $- != *i* ]]
then
	return
fi

# status colors
red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
reset="\[$(tput sgr0)\]"

# スクリプト読み込み
source $HOME/.config/dotfiles/src/.git-completion.bash
source $HOME/.config/dotfiles/src/.git-prompt.sh

# プロンプトに各種情報を表示
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

############### ターミナルのコマンド受付状態の表示変更
# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
# export PS1="${green}\h${reset}:${yellow}\W${reset}"'$(__git_ps1 ['${red}'%s'${reset}'])'"${reset}> "
export PS1='($(date +"%y/%m/%d;%H:%M:%S")) \[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1 "[%s]")\[\033[00m\]> '
##############



# completion
bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'


alias vpn='/opt/cisco/anyconnect/bin/vpn'


#my alias

alias nvimr="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
if [ "$(uname)" = 'Darwin' ]; then
    # export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
else
    # eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto'
fi
# Source global definitions
# if [ -f /etc/bashrc ]; then
# 	. /etc/bashrc
# fi
alias ic="ibmcloud"

# Makefile autocompletion
function _makefile_targets {
    local curr_arg;
    local targets;

    # Find makefile targets available in the current directory
    targets=''
    if [[ -e "$(pwd)/Makefile" ]]; then
        targets=$( \
            grep -oE '^[a-zA-Z0-9_-]+:' Makefile \
            | sed 's/://' \
            | tr '\n' ' ' \
        )
    fi

    # Filter targets based on user input to the bash completion
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${targets[@]}" -- $curr_arg ) );
}
complete -F _makefile_targets make
