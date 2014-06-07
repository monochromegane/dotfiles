# percol
alias -g P='|percol'
function percol-src() {
    local selected_dir=$(ghq list --full-path | percol --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N percol-src
bindkey '^S' percol-src

function exists { which $1 &> /dev/null }
function percol_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
}

zle -N percol_select_history
bindkey '^R' percol_select_history
