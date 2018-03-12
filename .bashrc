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
source $HOME/dotfiles/.git-completion.bash
source $HOME/dotfiles/.git-prompt.sh

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
export PS1='\[\033[1;32m\]\u@\h<'$UDOCKER_NAME'>\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1 "[%s]")\[\033[00m\]> '
##############



# completion
bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'

# Source global definitions
# if [ -f /etc/bashrc ]; then
# 	. /etc/bashrc
# fi

# User specific aliases and functions
alias matlab='matlab -nodisplay'
# alias open='~/local/bin/open'
# alias ls='ls --color=auto -F'
# alias ll='ls --color=auto -F -lh'
alias getdisplay='echo $DISPLAY; echo $DISPLAY > $HOME/.X11Display'
alias setdisplay='export DISPLAY=`cat $HOME/.X11Display`'
#alias isub='$HOME/repos/isub/launch'
alias emacs='emacs -nw'
