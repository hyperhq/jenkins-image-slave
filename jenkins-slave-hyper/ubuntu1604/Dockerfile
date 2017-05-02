#REFERENCE Image
#jenkinsci/slave:latest

#FROM hyperhq/jenkins-slave-golang:1.7-ubuntu
FROM hyperhq/jenkins-image-slave:go1.8-ubuntu1604
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

##########################################
##   prepare build env for hyperstart   ##
##########################################
ENV DEBIAN_FRONTEND noninteractive
#ADD ./etc/apt/sources.list /etc/apt/sources.list

RUN apt-get update &&\
    apt-get install -y autoconf automake pkg-config libdevmapper-dev libsqlite3-dev libvirt-dev libvirt-bin aufs-tools unzip sudo curl wget libaio1 libpixman-1-0 \
    linux-image-extra-virtual xfsprogs &&\
    wget https://s3-us-west-1.amazonaws.com/hypercontainer-download/qemu-hyper/qemu-hyper_2.4.1-1_amd64.deb &&\
    dpkg -i --force-all qemu-hyper_2.4.1-1_amd64.deb &&\
    rm -rf qemu-hyper_2.4.1-1_amd64.deb &&\
    ln -s /usr/lib/x86_64-linux-gnu/libxenctrl.so /usr/lib/x86_64-linux-gnu/libxenctrl-4.4.so &&\
    ln -s /usr/lib/x86_64-linux-gnu/libxenguest.so /usr/lib/x86_64-linux-gnu/libxenguest-4.4.so &&\
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

VOLUME ["/home/jenkins"]
WORKDIR $HOME
USER root
