#!/bin/bash


echo "** INSTALL EPEL repository **"
yum install -y epel-release
yum makecache

echo "** INSTALL PRE-REQS **"
yum install -y  which           \
                git-core        \
                git             \
                zlib            \
                zlib-devel      \
                gcc-c++         \
                patch           \
                readline        \
                readline-devel  \
                libyaml-devel   \
                libffi-devel    \
                openssl-devel   \
                make            \
                bzip2           \
                autoconf        \
                automake        \
                libtool         \
                bison           \
                curl            \
                sqlite-devel    \
                ansible         \
                createrepo


echo "** INSTALL RUBY **"
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#exec $SHELL
source $HOME/.bash_profile

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#exec $SHELL
source $HOME/.bash_profile

echo "** INSTALL RBENV **"
rbenv install 2.7.0

echo "Set rbenv version"
rbenv global 2.7.0
echo "Display ruby version"
ruby -v
echo "** INSTALL Bundler, capistrano, puppet **"
gem install bundler \
            capistrano \
            puppet
echo "** List installed gems **"
gem list

echo
echo "Finished installing dependencies. Rbenv version is `rbenv version`."
echo "Please restart your shell session to pick up the changes made by the installer."

