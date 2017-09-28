#!/bin/bash

set -e

repo="hyperhq/docker-in-hyper"
tag="slave_ubuntu16.04-17.09.0"
image=${repo}:${tag}


function build(){
    echo "starting build..."
    echo "=============================================================="
    docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t ${image} .
}

function push(){

    echo -e "\nstarting push [${image}] ..."
    echo "=============================================================="
    docker tag ${image} ${repo}:jenkins-slave
    docker push ${image}
    docker push $repo:jenkins-slave
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
