#!/bin/bash

set -x

export RBENV_VERSION=2.5.3
export RUBY_VERSION=2.5.0
export BUNDLER_VERSION=1.17.3

if [ `whoami` != "install" ]
then
   echo "Error : Have to execute this script as install user ..."
   exit 1
fi

echo "** INSTALL EPEL repository **"
sudo yum install -y epel-release
sudo yum makecache

echo "** INSTALL PRE-REQS **"
sudo yum install -y  which           \
                mlocate           \
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
                unzip           \
                wget            \
                autoconf        \
                automake        \
                libtool         \
                bison           \
                curl            \
                sqlite-devel    \
                ansible         \
                createrepo

echo "** CREATE deployer USER **"
sudo mkdir -p /opt/workspace/delivery

chown -R install:install /opt/workspace
echo "Download rbenv_install script :"
curl -fsSL https://raw.githubusercontent.com/ohhfrancois/workspace_installer/main/rbenv_install.sh -o /tmp/rbenv_install.sh
chmod +x  /tmp/rbenv_install.sh


echo "** Install Ruby, rbenv, ... to root user **"
/tmp/rbenv_install.sh
echo "** Install Bundler, Capistrano, Puppet to root user**"
gem install bundler:${BUNDLER_VERSION} capistrano puppet

echo "** WORKSPACE INITIALISATION FINISHED **"
