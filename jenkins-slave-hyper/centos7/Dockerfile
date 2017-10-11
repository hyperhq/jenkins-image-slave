#REFERENCE Image
#jenkinsci/slave:latest

FROM hyperhq/jenkins-image-slave:go1.8-centos7
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

##########################################
##            intall mongodb            ##
##########################################
RUN yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm &&\
    yum install -y Percona-Server-MongoDB-32 &&\
    yum clean all

##########################################
##    prepare jenkins slave run env     ##
##########################################
ENV HOME /home/jenkins
VOLUME ["/home/jenkins"]


##########################################
##        prepare java run env        ##
##########################################
ENV JAVA_HOME /usr/java/jdk1.8.0_101
ENV PATH $PATH:$JAVA_HOME/bin

##########################################
##        prepare golang run env        ##
##########################################
ENV GOPATH $HOME/workspace/gopath
ENV GOROOT /usr/local/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
RUN mkdir -p $GOPATH

##########################################
WORKDIR $HOME
USER root
