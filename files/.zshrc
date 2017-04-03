## 文字コードの設定
export LANG=ja_JP.UTF-8
export PATH="/usr/local/mysql/bin:/sbin:$PATH"

# --------------------------------------------------------------

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# .oh-my-zshの自動更新を停止
export DISABLE_AUTO_UPDATE="true"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="risto"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# nodebrewへのパス
export PATH=$HOME/.nodebrew/current/bin:$PATH

# --------------------------------------------------------------
# --------------------- 一般設定
# --------------------------------------------------------------

## 履歴
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

# 補完機能の強化
autoload -U compinit
compinit -u
# プロンプトの設定
autoload colors
colors
# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'
# コアダンプサイズを制限
limit coredumpsize 102400
# 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
# 色を使う
setopt prompt_subst
# ビープを鳴らさない
setopt nobeep
# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
# 補完候補一覧でファイルの種別をマーク表示
setopt list_types
# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
# 補完候補を一覧表示
setopt auto_list
# 補完候補を詰めて表示
setopt list_packed
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# cd 時に自動で push
setopt autopushd
# 同じディレクトリを pushd しない
setopt pushd_ignore_dups
# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
# TAB で順に補完候補を切り替える
setopt auto_menu
# zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
# =command を command のパス名に展開する
setopt equals
# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
# ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
# 出力時8ビットを通す
setopt print_eight_bit
# ヒストリを共有
setopt share_history
# ディレクトリ名だけで cd
setopt auto_cd
# カッコの対応などを自動的に補完
setopt auto_param_keys
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# スペルチェック
setopt correct
# 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# sudo に対して環境変数 PATH を継承させる設定
alias sudo='sudo env PATH=$PATH'

# -u を認識しなくて、userを変更してコマンドが実行できないため
# http://d.hatena.ne.jp/japanrock_pg/20090527/1243426081
#export PATH=/usr/local/bin:$PATH
#alias sudo="sudo PATH=$PATH"

# cdr
autoload -Uz is-at-least
if is-at-least 4.3.11
then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-max 5000
    zstyle ':chpwd:*' recent-dirs-default yes
    zstyle ':completion:*' recent-dirs-insert both
fi

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

# --------------------------------------------------------------
# --------------------- 拡張設定
# --------------------------------------------------------------

# node.js(nvm)
if [ -e ~/.nvm/nvm.sh ]; then
    source ~/.nvm/nvm.sh
fi

# SSH agentを起動
# ssh-add ~/.ssh/id_dsa で鍵とパスフレーズを紐つけて登録
echo -n "ssh-agent: "
if [ -e ~/.ssh-agent-info ]; then
    source ~/.ssh-agent-info
fi

ssh-add -l >&/dev/null
if [ $? = 2 ] ; then
    echo -n "ssh-agent: restart...."
    ssh-agent >~/.ssh-agent-info
    source ~/.ssh-agent-info
fi

if ssh-add -l >&/dev/null ; then
    echo "ssh-agent: Identity is already stored."
else
    ssh-add
fi

# mosh
# known_hostsを使ってエイリアス名の入力補完をしたい場合は、
# .zshrcに以下を追記するとsshを使うときと同様にサーバのエイリアス名の補完機能を使えるようになります。
compdef mosh=ssh


# Z
# http://qiita.com/takc923/items/36ace951569160068527
# https://github.com/rupa/z

source ~/.dotfiles/lib/z/z.sh

# gtm
# https://github.com/git-time-metric/gtm-terminal-plugin

source ~/.dotfiles/lib/.gtm-terminal-plugin/gtm-plugin.sh

# --------------------------------------------------------------
# --------------------- エイリアス
# --------------------------------------------------------------


## エイリアス - 一般
setopt complete_aliases

case "${OSTYPE}" in
freebsd*|darwin*)
alias ls="ls -G -w"
;;
linux*)
alias ls="ls --color"
;;
esac
alias l="ls -lah"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -lh"
alias du="du -h"
alias df="df -h"
alias duu="du -d 1"

## エイリアス - tmux
alias tm="tmux a"
alias tmn="tmux new -s"
alias tig='tig --all'
alias t='TIG_LS_REMOTE="git ls-remote . master dev origin/* develop development i*" tig'

## エイリアス - git
alias gco="git checkout"
alias gst="git status"
alias gad="git add ."
alias gc="git commit"
alias gdi="git diff"
alias gbr="git branch"

## 上書き確認

alias mv='mv -i'
alias cp='cp -i'

## git-archive-all
alias git-archive-all='~/.dotfiles/git-archive-all'

# cd && ll
cd() {
    builtin cd "$@"
    echo "success"
}
cdls ()
{
    \cd "$@" && ls -lh
}
alias cd="cdls"

# colordiff
if [[ -x `which colordiff` ]]; then
      alias diff='colordiff'
fi

# --------------------------------------------------------------
# --------------------- キーバインド
# --------------------------------------------------------------

# bin/menuスクリプトがある場合実行
function _showMenu() {
    if [ -e ./bin/menu ]; then
        exec < /dev/tty
        echo bin/menu
        ./bin/menu
    fi
    zle reset-prompt
}
zle -N showMenu _showMenu
bindkey '^N' showMenu

# ll を実行
function doLL() {
    echo ll
    ls -l
    zle reset-prompt
}
zle -N doLL
bindkey '^L' doLL

# git statusを実行
function gitStatus() {
    echo gst
    gst
    zle reset-prompt
}
zle -N gitStatus
bindkey '^G' gitStatus

# sentaku explorerを実行
function sentaku() {
    exec < /dev/tty
    echo sentaku
    jump=`sh ~/.dotfiles/lib/sentaku/ex_explorer.sh`
    cd $jump
    cd ../`basename $jump`
    ls -l
    zle reset-prompt
}
zle -N sentaku
bindkey '^F' sentaku

# --------------------------------------------------------------
# --------------------- コマンド
# --------------------------------------------------------------


# コミット間の差分を取得して、zipで固める
# --format=zip を付けるとzipで固めてくれます。
# --prefix=root/ は抽出したファイルをrootディレクトリに入れた状態にしてくれます。
# -o archive.zip で出力先と出力名を指定しています。
# 引数なしで git_diff_archive と呼ぶと HEAD を丸っとzipにします。
# 引数に数値を指定すると、HEAD と HEAD~数値 の差分を抽出します。
# 引数にコミット識別子(IDとかHEADとかHEAD^とかdiffの引数として使えるもの)を指定すると、
# HEAD と コミット識別子 の差分を抽出します。)
# コミット識別子を2つ渡すと、その2つのコミットの差分を抽出します。
# ちょっと前のバージョンの差分が欲しいとか言われたときに使えます。
# 渡す順番は新しいコミット、古いコミットの順番で渡してください。
# http://qiita.com/kaminaly/items/28f9cb4e680deb700833

function git_diff_archive() 
{
    local diff=""
    local h="HEAD"
    if [ $# -eq 1 ]; then
        if expr "$1" : '[0-9]*' > /dev/null ; then
            diff="HEAD HEAD~${1}"
        else
            diff="HEAD ${1}"
        fi
    elif [ $# -eq 2 ]; then
        diff="${1} ${2}"
        h=$1
    fi
    if [ "$diff" != "" ]; diff="git diff --name-only ${diff}"
    git archive --format=zip --prefix=root/ $h `eval $diff` -o archive.zip
}

# rmコマンド実行時に、ファイルを削除するのではなく、
# /tmp/.trash/[user]ディレクトリに移動する
function soft_rm()
{
    # /tmp/.trashディレクトリがない場合作成
    if [ ! -d /tmp/.trash ] ; then
        mkdir /tmp/.trash
    fi
    # /tmp/.trashにユーザーのディレクトリがない場合作成
    if [ ! -d /tmp/.trash/$USER ] ; then
        mkdir /tmp/.trash/$USER
    fi
    # /tmp/.trash/[user]に日付のディレクトリがない場合作成
    d="`date +%Y%m%d`"
    if [ ! -d /tmp/.trash/$USER/$d ] ; then
        mkdir /tmp/.trash/$USER/$d
    fi
    # 引数のファイルを/tmp/.trash/[ユーザー名に移動]
    for file in $@
    do
        fn=$file
        fn2=${fn//\//___}
        fnf=`date '+%y%m%d%H%M%S'`
        fnc="${fnf}_${fn2}"
        mv $file /tmp/.trash/$USER/$d/$fnc
        
    done
}
alias rm="soft_rm"

# 全てのブランチをpull
function git_pull_all()
{
    for branch in `git branch -r | grep -v HEAD | awk -F'/' '{print $2}'`; do git checkout $branch; git pull; done
}

# Docker QuickStart Terminal.appへのショートカット
function docker_quick_start()
{
    docker ps >/dev/null 2>&1
    # 正常終了しない場合
    # （dockerデーモンが起動しない場合）
    if [ ! $? = 0 ]; then
        start=/Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh
        if [ -e "$start" ]; then
            "$start"
        else
            echo "Docker Quickstart Terminal.appが見つかりません"
        fi
    else
        echo "既にDockerデーモンが起動しています"
    fi
}

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
