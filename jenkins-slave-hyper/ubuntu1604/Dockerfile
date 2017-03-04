#REFERENCE Image
#jenkinsci/slave:latest

FROM hyperhq/jenkins-slave-golang:1.7-ubuntu
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

##########################################
##   prepare build env for hyperstart   ##
##########################################
ENV DEBIAN_FRONTEND noninteractive
ADD ./etc/apt/sources.list /etc/apt/sources.list

## enable aufs
RUN apt-get update &&\
    apt-get install -y linux-image-extra-virtual &&\
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update &&\
    apt-get install -y autoconf automake pkg-config libdevmapper-dev libsqlite3-dev libvirt-dev qemu libvirt-bin aufs-tools unzip sudo curl &&\
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN cd `mktemp -d` &&\
    wget https://git.fedorahosted.org/cgit/lvm2.git/snapshot/lvm2-2_02_131.tar.xz &&\
    tar xf lvm2-2_02_131.tar.xz &&\
    cd lvm2-2_02_131 &&\
    ./configure &&\
    make device-mapper &&\
    make install &&\
    rm -rf /tmp/*

# enable xfs
RUN apt-get update &&\
    apt-get install -y xfsprogs &&\
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/home/jenkins"]
WORKDIR $HOME
USER root
