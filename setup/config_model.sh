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
    # wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_linux.zip && unzip ngccli_linux.zip && chmod u+x ngc-cli/ngc
    # find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5
    # echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> ~/.bash_profile && source ~/.bash_profile
    
    # mkdir -p /models
    # cd /models
    # ngc registry model download-version "nvstaging/clara/megamolbart:0.2.0"


    # download model from ngc into /models
    # cwd=$(pwd)

    MEGAMOLBART_MODEL_VERSION="0.1"
    DOWNLOAD_URL="https://api.ngc.nvidia.com/v2/models/nvidia/clara/megamolbart/versions/${MEGAMOLBART_MODEL_VERSION}/zip"
    MEGAMOLBART_MODEL_PATH="/models"

    mkdir -p ${MEGAMOLBART_MODEL_PATH}
    wget -q --show-progress \
            --content-disposition ${DOWNLOAD_URL} \
            -O ${MEGAMOLBART_MODEL_PATH}/megamolbart_${MEGAMOLBART_MODEL_VERSION}.zip
    mkdir ${MEGAMOLBART_MODEL_PATH}/megamolbart_v${MEGAMOLBART_MODEL_VERSION}
    unzip -q ${MEGAMOLBART_MODEL_PATH}/megamolbart_${MEGAMOLBART_MODEL_VERSION}.zip \
            -d ${MEGAMOLBART_MODEL_PATH}/megamolbart_v${MEGAMOLBART_MODEL_VERSION}
    
    
    # cd $cwd

    # download cheminformatics repo for chembench
    mkdir -p /opt/nvidia && \
        git clone https://github.com/NVIDIA/cheminformatics.git \
        --branch rilango/merged_bm_0.2 /opt/nvidia/cheminformatics
    
fi
