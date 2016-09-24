#REFERENCE Image
#jenkinsci/slave:latest

FROM centos/php-56-centos7:latest
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

##########################################
##    prepare jenkins slave run env     ##
##########################################
USER root
ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins
RUN mkdir /home/jenkins/.tmp
VOLUME ["/home/jenkins"]


##########################################
##        prepare java run env          ##
##########################################
#RUN yum update
RUN yum install -y wget make git which && yum clean packages
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
WORKDIR $HOME

##########################################
##        prepare ant run env        ##
##########################################
RUN wget http://apache.mesi.com.ar/ant/binaries/apache-ant-1.9.7-bin.tar.gz -O /opt/apache-ant-1.9.7-bin.tar.gz \
    && cd /opt/ && tar xzvf apache-ant-1.9.7-bin.tar.gz && rm -rf apache-ant-1.9.7-bin.tar.gz
ENV ANT_HOME /opt/apache-ant-1.9.7
ENV PATH $ANT_HOME/bin:$PATH
ENV CLASSPATH=.
