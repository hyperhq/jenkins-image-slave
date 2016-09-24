#REFERENCE Image
#jenkinsci/slave:latest

FROM centos:7.2.1511
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

##########################################
##    prepare jenkins slave run env     ##
##########################################
ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins
RUN mkdir /home/jenkins/.tmp
VOLUME ["/home/jenkins"]


##########################################
##        prepare java run env        ##
##########################################
#RUN yum update -y
RUN yum install -y wget && yum clean packages
RUN wget --no-check-certificate --no-cookies \
        --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.rpm \
		&& rpm -ivh jdk-8u101-linux-x64.rpm && rm -rf jdk-8u101-linux-x64.rpm
# RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k \
# 		https://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.rpm \
# 		&& rpm -ivh jdk-8u101-linux-x64.rpm && rm -rf jdk-8u101-linux-x64.rpm
ENV JAVA_HOME /usr/java/jdk1.8.0_101
ENV PATH $PATH:$JAVA_HOME/bin


##########################################
RUN yum install -y make git which && yum clean packages

WORKDIR $HOME
USER root
