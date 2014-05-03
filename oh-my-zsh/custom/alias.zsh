# alias
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -u $HOME/.vimrc "$@"'
alias vimdiff='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/vimdiff -u $HOME/.vimrc "$@"'
alias vi=vim
alias gs="git status -s -b && git stash list"
alias be='bundle exec'
alias beu="bundle exec rails unicorn -c config/unicorn.rb"
alias ber="bundle exec rake routes"
 
alias cdd="cd ~/Documents"
alias f="fg"
alias bundle='nocorrect bundle'
