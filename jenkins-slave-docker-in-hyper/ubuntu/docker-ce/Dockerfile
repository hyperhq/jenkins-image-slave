FROM hyperhq/docker-in-hyper:ubuntu16.04-17.09.0
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
RUN \
  apt-get update && \
  apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean && \
  rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


##########################################
RUN apt-get update && apt-get install -y make gcc git rsync screen && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR $HOME
USER root

##########################################
VOLUME /var/lib/docker

EXPOSE 2375

ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock

ADD run-docker.sh /root/run-docker.sh
