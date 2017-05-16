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
RUN yum install -y wget && yum clean all
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
##        prepare golang run env        ##
##########################################
ENV GOLANG_VERSION 1.8
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
#ENV GOLANG_DOWNLOAD_URL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz
#ENV GOLANG_DOWNLOAD_URL http://golangtc.com/static/go/1.7/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca
RUN wget "$GOLANG_DOWNLOAD_URL" -O golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH $HOME/workspace/gopath
ENV GOROOT /usr/local/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
RUN mkdir -p $GOPATH

##########################################
RUN rpm --rebuilddb && touch /var/lib/rpm/* && yum install -y make git which gcc && yum clean all 

WORKDIR $HOME
USER root
