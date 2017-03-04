#REFERENCE Image
#jenkinsci/slave:latest

#FROM hyperhq/jenkins-slave-golang:1.7-ubuntu-1404
FROM hyperhq/jenkins-image-slave:go1.8-ubuntu1404
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

##########################################
##   prepare build env for hyperstart   ##
##########################################
ENV DEBIAN_FRONTEND noninteractive
#ADD ./etc/apt/sources.list /etc/apt/sources.list

RUN apt-get update &&\
    apt-get install -y autoconf automake pkg-config libdevmapper-dev libsqlite3-dev libvirt-dev qemu libvirt-bin aufs-tools unzip sudo curl \
    linux-image-extra-virtual xfsprogs && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd `mktemp -d` &&\
    wget ftp://sources.redhat.com/pub/lvm2/LVM2.2.02.131.tgz &&\
    tar xf LVM2.2.02.131.tgz &&\
    cd LVM2.2.02.131 &&\
    ./configure &&\
    make device-mapper &&\
    make install &&\
    rm -rf /tmp/*

VOLUME ["/home/jenkins"]
WORKDIR $HOME
USER root
