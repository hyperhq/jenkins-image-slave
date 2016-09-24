#REFERENCE Image
#jenkinsci/slave:latest

FROM centos:7.2.1511
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

#RUN yum update -y
RUN yum install -y which wget && yum clean packages

##########################################
##        prepare java run env          ##
##########################################
RUN yum install -y java-1.8.0-openjdk && yum clean packages
ENV JAVA_HOME /usr/lib/jvm/`rpm -qa java-1.8.0-openjdk`
ENV PATH $PATH:${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin

##########################################
##        prepare golang run env        ##
##########################################
RUN yum install -y make git go && yum clean packages
ENV GOPATH /home/jenkins
ENV PATH $PATH:$GOPATH/bin

##########################################
##    prepare jenkins slave run env     ##
##########################################
ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins

WORKDIR $HOME
USER root

RUN mkdir /home/jenkins/.tmp

VOLUME ["/home/jenkins"]
