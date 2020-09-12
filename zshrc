fpath=(~/.zsh/functions $fpath)

# Prompt
autoload -U colors; colors
PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%~%{$fg_bold[blue]%}$(_git-prompt-info)%{$reset_color%} '
setopt prompt_subst

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space

# Golang
export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

# Ruby
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init --no-rehash -)"
fi

# Python
if [ -d ~/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --no-rehash -)"
fi

# Node
export PATH=$HOME/.nodebrew/current/bin:$PATH

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

# completion
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
source ~/.zsh/incr.zsh

# peco
zle -N peco-ghq _peco-ghq
setopt noflowcontrol # Workaround for using ^S
bindkey '^S' peco-ghq

zle -N peco-select-history _peco-select-history
bindkey '^R' peco-select-history

# alias
alias ls='ls -G'
alias ll='ls -l'

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gco='git checkout'

alias vi=vim
alias gs="git status -s -b && git stash list"
alias be='bundle exec'
alias bi='bundle install'
alias rake="noglob rake"
alias f="fg"
alias bundle='nocorrect bundle'
function cd() {builtin cd $@ && ls}
p() { peco | while read LINE; do $@ $LINE; done }
alias s='ghq list -p | p cd'
alias gcp='git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`'
alias gcop='gcp'
alias ggpush='git push origin $(_git_current_branch)'
alias ggpull='git pull origin $(_git_current_branch)'

# autoload
autoload -Uz _git-prompt-info
autoload -Uz _git_current_branch
autoload -Uz _peco-select-history
autoload -Uz _peco-ghq
