#!/bin/bash

echo "$0 START"
set -e

RBENV_VERSION=2.5.3
RUBY_VERSION=2.5.0
BUNDLER_VERSION=1.17.3

# Delete ~/.rbenv/.installed to make this script run again
if [ -f ~/.rbenv/.installed ] ; then
  echo "Rbenv installed, nothing to do."
  exit 0
fi

echo Installing dependencies...
echo This script is based on https://doki.XXX.com/display/OCD/Installing+Ruby

# rbenv
if [ ! -d  ~/.rbenv ] ; then
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

	# .profile updates
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

	# Run these now to be available for installer
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# ruby-build
if [ ! -d ~/.rbenv/plugins/ruby-build/ ] ; then
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# install ruby 2.0.0
if [ ! -d ~/.rbenv/versions/${RUBY_VERSION} ] ; then
	echo "Building and installing ruby${RUBY_VERSION}, this will take a LONG TIME, please be patient"
	rbenv install ${RUBY_VERSION}
#	ln -s ~/.rbenv/versions/${RUBY_VERSION} ~/.rbenv/versions/${RUBY_VERSION}
	rbenv global ${RUBY_VERSION}
fi

# bundler
if [ ! -f ~/.rbenv/versions/${RUBY_VERSION}/bin/bundler ] ; then
	rbenv exec gem install bundler:${BUNDLER_VERSION} --no-ri --no-rdoc
	rbenv rehash
fi

# rbenv-bundler
if [ ! -d ~/.rbenv/plugins/bundler ] ; then
	git clone -- https://github.com/carsomyr/rbenv-bundler.git ~/.rbenv/plugins/bundler
fi

echo "Created by the install_ruby script to indicate that rbenv is installed" > ~/.rbenv/.installed

echo "** DISPLAY VERSIONS : **"
echo "rbenv version : `rbenv --version`"
echo "ruby version: `ruby --version`"
echo "gem version: `gem --version`"
echo "bundle version: `bundle --version`"

echo
echo "Finished installing dependencies. Rbenv version is `rbenv version`."
echo "Please restart your shell session to pick up the changes made by the installer."
echo "$0 END"
