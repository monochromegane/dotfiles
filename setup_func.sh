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
      ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi
  fi
}

function install_packages {
  type go
  if [ $? -ne 0 ]; then
    is_debian && aptitude -y install golang
    is_osx    && brew install go
    is_centos && yum -y install golang
  fi

  type vim
  if [ $? -ne 0 ]; then
    is_debian && aptitude -y install vim
    is_osx    && brew install vim
    is_centos && yum -y install vim
  fi

  type zsh
  if [ $? -ne 0 ]; then
    is_debian && aptitude -y install zsh
    is_osx    && brew install zsh
    is_centos && yum -y install zsh
  fi

  type git
  if [ $? -ne 0 ]; then
    is_debian && aptitude -y install git
    is_osx    && brew install git
    is_centos && yum -y install git
  fi

  type tig
  if [ $? -ne 0 ]; then
    is_debian && aptitude -y install tig
    is_osx    && brew install tig
    if is_centos; then
      rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
      yum -y install tig
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
