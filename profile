#!/bin/bash

set -o vi

export HOMEBREW_NO_ENV_HINTS=true

if [[ ${HOSTNAME} == *mac* || ${HOSTNAME} == *V-* || ${HOSTNAME} == *DESKTOP* ]]; then
    export PS1="\[\e[1;33m\]\u\[\e[m\]:\[\e[1;32m\]\w\[\e[m\]: "
else
    export PS1="\[\e[1;33m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[m\]:\[\e[1;37m\]\w\[\e[m\]: "
fi

export EDITOR='nvim'
export VISUAL='nvim'

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

export PATH="${PATH:+${PATH}:}/usr/local/go/bin"
export PATH="${PATH:+${PATH}:}/usr/local/bat"
export PATH="${PATH:+${PATH}:}/usr/local/exa/bin"
export PATH="${PATH:+${PATH}:}/usr/local/nvim/bin"

alias get='git'
alias git-log='git log --date=short --pretty="%h  %cd  %s"'
alias gl='git-log'
alias git-out='git commit --amend --date="$(date -R)" --no-edit; git push --force'
alias git-fetch-checkout='git fetch; git checkout'
alias git-fetch-rebase='git fetch; git rebase -i'
alias gs='git status'
alias gfs='git fetch; git status'
alias gfc='git-fetch-checkout'
alias gfr='git-fetch-rebase'
alias gl='git-log'
alias grc='git rebase --continue'

alias watch="watch "

alias pipes="pipes.sh"
alias neofetch="neofetch --config ~/.files/neofetch.conf"

alias azl='az login --use-device-code'

if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path --no-rehash)"
    eval "$(pyenv init - --no-rehash)"
    eval "$(pyenv virtualenv-init - --no-rehash)"
fi

if command -v cargo &> /dev/null; then
    alias cargo-watch='cargo watch -q -c -w src/ -x run'
fi

if command -v just &> /dev/null; then
    source <(just --completions bash)
fi

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

if command -v nvim &> /dev/null; then
    alias vim='nvim'
fi

if command -v bat &> /dev/null; then
    alias cat='bat -p'
    alias less='bat'
fi

if command -v exa &> /dev/null; then
    alias ls='exa -la'
    alias lt='exa -lDTL 2'
    alias tree='exa -T'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
fi

if command -v fzf &> /dev/null; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

if [ -f /usr/local/bin/z.sh ]; then
    source /usr/local/bin/z.sh
fi

source $HOME/.files/k8s
source $HOME/.files/k8s-logs.sh
source $HOME/.files/functions

