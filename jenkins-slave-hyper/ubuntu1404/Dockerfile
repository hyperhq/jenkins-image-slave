#REFERENCE Image
#jenkinsci/slave:latest

FROM hyperhq/jenkins-image-slave:go1.8-ubuntu1404
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

#################################################
##   prepare build env for hyperd/hyperstart   ##
#################################################

ENV DEBIAN_FRONTEND noninteractive
#ADD ./etc/apt/sources.list /etc/apt/sources.list

RUN apt-get update &&\
    apt-get install -y autoconf automake pkg-config libdevmapper-dev libsqlite3-dev libvirt-dev libvirt-bin aufs-tools unzip sudo curl wget libaio1 libpixman-1-0 \
    linux-headers-4.4.0-62-generic linux-image-extra-virtual xfsprogs &&\
    cp /usr/src/linux-headers-4.4.0-62/include/uapi/linux/vm_sockets.h /usr/include/linux &&\
    apt-get clean &&\
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://s3-us-west-1.amazonaws.com/hypercontainer-download/qemu-hyper/qemu-hyper_2.4.1-1_amd64.deb &&\
    dpkg -i --force-all qemu-hyper_2.4.1-1_amd64.deb &&\
    rm -rf qemu-hyper_2.4.1-1_amd64.deb &&\
    apt-get clean &&\
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd `mktemp -d` &&\
    wget ftp://sources.redhat.com/pub/lvm2/LVM2.2.02.131.tgz &&\
    tar xf LVM2.2.02.131.tgz &&\
    cd LVM2.2.02.131 &&\
    ./configure &&\
    make device-mapper &&\
    make install &&\
    rm -rf /tmp/*

RUN wget -q https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O /usr/bin/jq &&\
    chmod +x /usr/bin/jq

###############
##   other   ##
###############

## slack config
ENV SLACK_TOKEN=""
ENV SLACK_CHANNEL_ID=""

VOLUME ["/home/jenkins"]
WORKDIR $HOME
USER root

ADD script/slack.sh /usr/bin/slack.sh
ADD script/test-hyperd.sh /usr/bin/test-hyperd.sh
ADD script/test-hyperstart.sh /usr/bin/test-hyperstart.sh
