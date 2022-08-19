#!/bin/bash
set -e
set -x

PACKAGE=$1
NGC_TOKEN=$2

if [ ${PACKAGE} -eq 1 ]
then
    echo "Coping model from /tmp/models/ ..."
    mv /tmp/models/ /
    ls /models/
fi

if [ ${PACKAGE} -eq 2 ]
then
    # 0. get ngc cli
    wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_linux.zip && unzip ngccli_linux.zip && chmod u+x ngc-cli/ngc
    find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5
    echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> ~/.bash_profile && source ~/.bash_profile
    
    # 1. download model from ngc into /models
    # 2. download cheminformatics repo for chembench
        # mkdir/git clone, command from the cheminformatics dockerfile
    
fi
