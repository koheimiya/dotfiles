# .bashrc

# Check if intaractive
# if [[ $- != *i* ]]
# then
# 	return
# fi
CONFIGPATH=${XDG_CONFIG_HOME:-$HOME/.config}

case $SHELL in
*/bash)
    # スクリプト読み込み
    source $CONFIGPATH/.git-completion.bash
    source $CONFIGPATH/.git-prompt.sh
    # Bash completion for mac.
    [ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
    
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
   ;;
esac


alias vpn='/opt/cisco/anyconnect/bin/vpn'


#my alias

# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
alias nvimr="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"

if [[ "$(uname)" = 'Darwin' ]]; then
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
case $SHELL in
*/bash)
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
   ;;
esac


export PATH=$HOME/.local/bin:$PATH
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if command -v pyenv >/dev/null; then eval "$(pyenv init -)"; fi
case "$(uname -s)" in
    Linux*)
        ;;
    Darwin*)
        export PATH="$HOME/Library/Python/3.9/bin:$PATH"
        ;;
    *)
        echo WARNING Unsupported uname '(on installing python path)': ${unameOut}
esac
export EDITOR=nvim
export VISUAL=nvim


# texlive for linux
export MANPATH=/usr/local/texlive/2021/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2021/texmf-dist/doc/info:$INFOPATH
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH

# tex for vim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
