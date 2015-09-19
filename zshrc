ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

eval "$(direnv hook zsh)"
