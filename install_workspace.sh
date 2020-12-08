#!/bin/sh

yum install -y  ansible             \
                python-setuptools   \
                libffi-devel        \
                python-devel        \
                openssl-devel       \
                libselinux-python   \
                ansible             \
                ruby                \
                rubygem-bundler     \
                ruby-dev            \
                git                 \
                libxslt-dev         \
                libxml2-dev         \
                zlib1g-dev          \
                libssl-dev          \
                libreadline-dev     \
                unzip               \
                apache2             \
                createrepo

# Install ruby :
set -e

# Delete ~/.rubenv/.installed to make this script run again
if [ -f ~/.rbenv/.installed ] ; then
  exit 0
fi

echo Installing dependencies...
echo This script is based on https://XXX/Installing+Ruby

# rbenv
if [ ! -d  ~/.rbenv ] ; then
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

	# .profile updates
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
	echo 'eval "$(rbenv init -)"' >> ~/.profile

	# Run these now to be available for installer
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# ruby-build
if [ ! -d ~/.rbenv/plugins/ruby-build/ ] ; then
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# install ruby 2.0.0
if [ ! -d ~/.rbenv/versions/2.0.0-p598 ] ; then
	echo "Building and installing ruby 2.0.0, this will take a LONG TIME, please be patient"
	rbenv install 2.0.0-p598
	ln -s ~/.rbenv/versions/2.0.0-p598 ~/.rbenv/versions/2.0.0
	rbenv global 2.0.0
fi

# bundler
if [ ! -f ~/.rbenv/versions/2.0.0/bin/bundler ] ; then
	rbenv exec gem install bundler --no-ri --no-rdoc
	rbenv rehash
fi

# rbenv-bundler
if [ ! -d ~/.rbenv/plugins/bundler ] ; then
	git clone -- https://github.com/carsomyr/rbenv-bundler.git ~/.rbenv/plugins/bundler
fi

echo "Created by the install_ruby script to indicate that rbenv is installed" > ~/.rbenv/.installed

echo Finished installing dependencies. Rbenv version is `rbenv version`.
echo Please restart your shell session to pick up the changes made by the installer.

source $HOME/.bash_profile

gem install bundler capistrano puppet
