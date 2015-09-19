ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

if  [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

which direnv > /dev/null 2>&1
if [ $? -ne 1 ]; then
    eval "$(direnv hook zsh)"
fi

# local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
