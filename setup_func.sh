#!/bin/bash

function is_centos {
  [[ -f /etc/redhat-release ]]
}

function is_debian {
  [[ -f /etc/debian_version ]]
}

function is_osx {
  [[ $OSTYPE =~ ^darwin ]]
}

function install_package_manager {
  if is_osx; then
    type brew
    if [ $? -ne 0 ]; then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
  fi
}

function install_packages {
  type go
  if [ $? -ne 0 ]; then
    is_debian && sudo apt-get -y install golang
    is_osx    && brew install go
    is_centos && sudo yum -y install golang
  fi

  type vim
  if [ $? -ne 0 ]; then
    is_debian && sudo apt-get -y install vim
    is_osx    && brew install vim
    is_centos && sudo yum -y install vim
  fi

  type tmux
  if [ $? -ne 0 ]; then
    is_debian && sudo apt-get -y install tmux
    is_osx    && brew install tmux
    is_centos && sudo yum -y install tmux
  fi

  type zsh
  if [ $? -ne 0 ]; then
    is_debian && sudo apt-get -y install zsh
    is_osx    && brew install zsh
    is_centos && sudo yum -y install zsh
  fi

  type git
  if [ $? -ne 0 ]; then
    is_debian && sudo apt-get -y install git
    is_osx    && brew install git
    is_centos && sudo yum -y install git
  fi

  type tig
  if [ $? -ne 0 ]; then
    is_debian && sudo apt-get -y install tig
    is_osx    && brew install tig
    if is_centos; then
      sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
      sudo yum -y install tig
    fi
  fi

}

function install_go_tools {
  export GOPATH="$HOME"
  export PATH="$GOPATH/bin:$PATH"
  go get github.com/github/hub
  go get github.com/motemen/ghq
  go get github.com/peco/peco/cmd/peco
  go get github.com/monochromegane/mdt/...
  go get github.com/monochromegane/the_platinum_searcher/...
}
