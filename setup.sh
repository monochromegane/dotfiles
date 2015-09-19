#!/bin/bash

echo "====> Running setup..."
BASE_DIR=$(cd $(dirname $0);pwd)
cd $BASE_DIR

. setup_func.sh

echo "====> Install applications..."
install_package_manager
install_packages

# git
echo "====> Setup git..."
ln -sf $BASE_DIR/gitconfig ~/.gitconfig
for c in git_diff_wrapper git_editor_wrapper
do
  ln -sf $BASE_DIR/bin/$c ~/bin/$c
done

# tmux
echo "====> Setup tmux..."
ln -sf $BASE_DIR/tmux.conf ~/.tmux.conf

# vim
echo "====> Setup vim..."
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
ln -sf $BASE_DIR/vimrc ~/.vimrc
for c in neobundle.toml neobundlelazy.toml snippets
do
  ln -sf $BASE_DIR/$c ~/.vim/$c
done

# zsh
echo "====> Setup zsh..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf $BASE_DIR/zshrc ~/.zshrc

for c in alias.zsh incr.zsh peco.zsh
do
  ln -sf $BASE_DIR/oh-my-zsh/custom/$c ~/.oh-my-zsh/custom/$c
done

# go tools
echo "====> Install and seetup go tools..."
install_go_tools
ln -sf $BASE_DIR/peco ~/.peco

echo "====> Complete setup!"
exit 0
