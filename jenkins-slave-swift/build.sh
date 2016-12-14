#!/bin/bash

set -e

repo="hyperhq/jenkins-slave-swift"
tag="swift3"
image=${repo}:${tag}


function build(){
    echo "starting build..."
    echo "=============================================================="
    CMD="docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t ${image} ."
    echo "CMD: [ ${CMD} ]"
    eval $CMD
}

function push(){

    echo -e "\nstarting push [${image}] ..."
    echo "=============================================================="
    docker push ${image}

    echo -e "\nstarting push [${repo}:latest] ..."
    echo "=============================================================="
    docker tag ${image} ${repo}:latest
    docker push ${repo}:latest
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
