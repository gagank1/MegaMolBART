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
    # install ngc cli
    wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_linux.zip && unzip ngccli_linux.zip && chmod u+x ngc-cli/ngc
    find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5
    echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> ~/.bash_profile && source ~/.bash_profile

    # TODO: set ngc token before downloading the model from the ngc registry
    
    # download model from ngc into /models
    cwd=$(pwd)
    mkdir -p /models
    cd /models
    ngc registry model download-version "nvstaging/clara/megamolbart:0.2.0"
    cd $cwd

    # download cheminformatics repo for chembench
    mkdir -p /opt/nvidia && \
        git clone https://github.com/NVIDIA/cheminformatics.git \
        --branch rilango/merged_bm_0.2 /opt/nvidia/cheminformatics
    
fi
