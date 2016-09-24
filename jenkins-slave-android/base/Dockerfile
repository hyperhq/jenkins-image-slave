FROM ubuntu:14.04
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
##        prepare java run env        ##
##########################################
# Install java8
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean && \
  rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*


##########################################
##        prepare android run env       ##
##########################################
# Install Deps
RUN dpkg --add-architecture i386 && apt-get update &&\
    apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl unzip &&\
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy install tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
  tar xzf android-sdk.tgz && \
  rm -f android-sdk.tgz && \
  chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN echo y | android update sdk --all --no-ui --filter "platform-tools,tools"
RUN echo y | android update sdk --all --no-ui --filter "extra-android-support,extra-android-m2repository,extra-google-m2repository"

##########################################
##        prepare gradle run env        ##
##########################################
ENV DOWNLOAD_URL https://services.gradle.org/distributions/gradle-3.1-bin.zip
RUN mkdir -p /opt/ \
    && cd /opt/ \
    && wget $DOWNLOAD_URL \
    && unzip gradle-*.zip \
    && rm -f gradle-*.zip \
    && mv gradle-* gradle \
    && echo 'export GRADLE_HOME=/opt/gradle' >> /etc/profile \
    && echo 'export PATH=$GRADLE_HOME/bin:$PATH' >> /etc/profile

ENV GRADLE_HOME /opt/gradle
ENV PATH $GRADLE_HOME/bin:$PATH

# Support Gradle
ENV TERM dumb
ENV JAVA_OPTS -Xms256m -Xmx512m


# ##########################################
# ##        build aapt under 64bit        ##
# ##########################################
# # install dependencies for ./autogen.sh, ./configure and make
# RUN apt-get update && apt-get install -y libtool autoconf automake \
#     g++ \
#     make zlib1g-dev libssl-dev libexpat1-dev libpng12-dev && \
#     apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
# # download source
# RUN git clone https://github.com/Jimmy-Xu/android-utils.git /opt/android-utils &&\
#     cd /opt/android-utils && ./autogen.sh && ./configure && make &&\
#     mv /opt/android-utils/aapt/aapt /usr/bin/ &&\
#     rm -rf /opt/android-utils

##########################
##         final        ##
##########################
# Cleaning
RUN apt-get clean
# Use bash rather than dash
RUN rm /bin/sh && ln -s bash /bin/sh

WORKDIR $HOME
