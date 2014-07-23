# peco
p() { peco | while read LINE; do $@ $LINE; done }

# ghq list
alias s='ghq list -p | p cd'

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

# kill process
function peco-kill-process() {
    ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
}
alias psk='peco-kill-process'
