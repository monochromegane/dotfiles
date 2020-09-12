# alias
alias vi=vim
alias gs="git status -s -b && git stash list"
alias be='bundle exec'
alias bi='bundle install'
alias rakt="rake -T"
alias rakr="rake routes"
alias rake="noglob rake"

alias cdd="cd ~/Documents"
alias f="fg"
alias bundle='nocorrect bundle'

alias direnv_init="echo 'export PATH=\$PWD/bin:\$PATH' > .envrc && direnv allow"

function cd() {builtin cd $@ && ls}

alias pp='ps aux | peco'
