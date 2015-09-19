# peco
p() { peco | while read LINE; do $@ $LINE; done }

# ghq list
alias s='ghq list -p | p cd'
function peco-ghq () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ghq
bindkey '^s' peco-ghq

# select history
function exists { which $1 &> /dev/null }
function peco-select-history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
}

zle -N peco-select-history
bindkey '^R' peco-select-history

# select change directory history
function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr

bindkey '^i' peco-cdr

# kill process
function peco-kill-process() {
    ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
}
alias killp='peco-kill-process'

# git checkout
alias gcp='git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`'
alias gcop='gcp'
