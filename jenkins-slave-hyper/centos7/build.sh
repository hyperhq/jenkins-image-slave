#!/bin/bash

set -e

repo="hyperhq/jenkins-image-slave"
tag=go1.8-centos7-mgo
image=${repo}:${tag}


function build(){
    echo "starting build..."
    echo "=============================================================="
    docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t ${image} .
}

function push(){

    echo -e "\nstarting push [${image}] ..."
    echo "=============================================================="
    docker push ${image}

}


case "$1" in
    "push")
        build
        push
        ;;
    "")
        build
        ;;
    *)
        cat <<EOF
usage:
    ./build.sh             # build only
    ./build.sh push        # build and push
EOF
    exit 1
        ;;
esac



echo -e "\n=============================================================="
echo "Done!"
