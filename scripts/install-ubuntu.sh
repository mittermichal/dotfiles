#!/bin/sh
INSTALLDIR=${1:-$HOME}

echo -n "brew install? (OSX) [n/Y]"
read -n 1 use_brew

if [ "$use_brew" == "Y" ]; then
  bash $PWD/.brew
fi

echo -n "apt-get install? (debian) [n/Y]"
read -n 1 use_aptget

if [ "$use_aptget" == "Y" ]; then
  apt-get upgrade
  apt-get install npm zip git phantomjs vim mongodb zsh
fi

echo -n "npm install? [n/Y]"
read -n 1 use_npm

if [ "$use_npm" == "Y" ]; then
  npm upgrade
  npm i -g bower grunt-cli less, coffee-script
fi

echo "Initializing submodules..."
git submodule init && git submodule update

echo -n "vim configs? [n/Y]"
read -n 1 use_vim_configs

if [ "$use_vim_configs" == "Y" ]; then
	mv $INSTALLDIR/.vim $INSTALLDIR/.vim.old 2> /dev/null
	mv $INSTALLDIR/.vimrc $INSTALLDIR/.vimrc.old 2> /dev/null
  ln -s $PWD/.vim $INSTALLDIR/.vim
  ln -s $PWD/.vimrc $INSTALLDIR/.vimrc
fi

echo -n "bash configs? [n/Y]"
read -n 1 use_bash_configs

if [ "$use_bash_configs" == "Y" ]; then
	mv $INSTALLDIR/.bash $INSTALLDIR/.bash.old 2> /dev/null
	mv $INSTALLDIR/.bash_profile $INSTALLDIR/.bash_profile.old 2> /dev/null
  ln -s $PWD/.bash $INSTALLDIR/.bash
  ln -s $PWD/.bash_profile $INSTALLDIR/.bash_profile
fi
echo -n "zsh configs? [n/Y]"
read -n 1 use_zsh

if [ "$use_zsh" == "Y" ]; then
  ln -s $PWD/.zshrc $INSTALLDIR/.zshrc
  wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
fi

echo -n "Git config settings [n/Y]"
read -n 1 use_git_configs

if [ "$use_git" == "Y" ]; then
  echo -n "Name: "
  read git_name
  echo -ne "\nEmail: "
  read git_email
  cp $PWD/.gitconfig $INSTALLDIR/.gitconfig
  sed -i "s/%%GITNAME%%/$git_name/" $INSTALLDIR/.gitconfig
  sed -i "s/%%GITEMAIL%%/$git_email/" $INSTALLDIR/.gitconfig
fi

if [ ! -d $HOME/p ]; then
  echo "project directory, symlink from ~/p will be created"
  echo -n "Dir: "
  read projectdir
  if [ $projectdir ]; then
    ln -s $HOME/p $projectdir
  fi
fi
