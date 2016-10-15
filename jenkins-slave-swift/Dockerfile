#REFERENCE Image
#jenkinsci/slave:latest

#Ubuntu 14.04.5 LTS
FROM swiftdocker/swift
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
##     prepare oracle-jdk8 run env      ##
##########################################
RUN rm -rvf /var/lib/apt/lists/* && \
  apt-get -o Acquire::http::proxy="${HTTP_PROXY}" -y update && \
  apt-get -o Acquire::http::proxy="${HTTP_PROXY}" install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get -o Acquire::http::proxy="${HTTP_PROXY}" -y update && \
  apt-get -o Acquire::http::proxy="${HTTP_PROXY}" install -y oracle-java8-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

WORKDIR $HOME
USER root
