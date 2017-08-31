FROM hyperhq/docker-in-hyper:centos7
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
        http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm \
		&& rpm -ivh jdk-8u141-linux-x64.rpm && rm -rf jdk-8u141-linux-x64.rpm
ENV JAVA_HOME /usr/java/jdk1.8.0_141
ENV PATH $PATH:$JAVA_HOME/bin

##########################################
RUN rpm --rebuilddb && touch /var/lib/rpm/* && yum install -y make git which gcc screen && yum clean all 

WORKDIR $HOME
USER root


##########################################
VOLUME /var/lib/docker

EXPOSE 2375

ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/bin/dockerd-current \
          --add-runtime docker-runc=/usr/libexec/docker/docker-runc-current \
          --host=unix:///var/run/docker.sock \
          --host=tcp://0.0.0.0:2375 \
          --default-runtime=docker-runc \
          --userland-proxy-path=/usr/libexec/docker/docker-proxy-current

ADD run-docker.sh /root/run-docker.sh
