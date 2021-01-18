# TODO: Change the test due to install user instead of root user
docker run --name centos_ruby_install -v "$PWD:/tmp/install"   --rm -i -t centos:7 /tmp/install/install_workspace.sh
#docker run --name centos_ruby_install -v "$PWD:/tmp/install"  -i -t centos:7 /tmp/install/install_workspace.sh
 

