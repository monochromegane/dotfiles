# oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Golang
export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

# Ruby
if  [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

# direnv
which direnv > /dev/null 2>&1
if [ $? -ne 1 ]; then
    eval "$(direnv hook zsh)"
fi

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 3000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
