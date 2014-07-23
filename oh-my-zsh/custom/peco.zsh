# peco
p() { peco | while read LINE; do $@ $LINE; done }
alias s='ghq list -p | p cd'

function exists { which $1 &> /dev/null }
function peco_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
}

zle -N peco_select_history
bindkey '^R' peco_select_history
