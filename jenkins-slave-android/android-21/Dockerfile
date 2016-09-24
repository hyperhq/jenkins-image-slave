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
RUN echo y | android update sdk --no-ui --all --filter "android-21"
RUN echo y | android update sdk --no-ui --all --filter "build-tools-21.0.2"
#RUN echo y | android update sdk --no-ui --all --filter "addon-google_apis_x86-google-21"
#RUN echo y | android update sdk --no-ui --all --filter "sys-img-armeabi-v7a-android-21"

# # Create emulator(too large)
# RUN echo "no" | android create avd \
#                 --force \
#                 --device "Nexus 5" \
#                 --name test \
#                 --target android-21 \
#                 --abi armeabi-v7a \
#                 --skin WVGA800 \
#                 --sdcard 512M


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

##########################################
##       prepare maven run env          ##
##########################################
ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

VOLUME "$USER_HOME_DIR/.m2"

##########################################
##        prepare ant run env           ##
##########################################
RUN wget http://apache.mesi.com.ar/ant/binaries/apache-ant-1.9.7-bin.tar.gz -O /opt/apache-ant-1.9.7-bin.tar.gz \
    && cd /opt/ && tar xzvf apache-ant-1.9.7-bin.tar.gz && rm -rf apache-ant-1.9.7-bin.tar.gz
ENV ANT_HOME /opt/apache-ant-1.9.7
ENV PATH $ANT_HOME/bin:$PATH
ENV CLASSPATH=.

# ##########################################
# ##        build aapt under 64bit        ##
# ##########################################
# # install dependence for ./autogen.sh, ./configure and make
# RUN apt-get update && apt-get install -y libtool autoconf automake \
#     g++ \
#     make zlib1g-dev libssl-dev libexpat1-dev libpng12-dev && \
#     apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
# # download source
# RUN git clone https://github.com/Jimmy-Xu/android-utils.git /opt/android-utils &&\
#     cd /opt/android-utils && ./autogen.sh && ./configure && make &&\
#     rm -rf ${ANDROID_HOME}/build-tools/21.0.2/aapt &&\
#     mv /opt/android-utils/aapt/aapt ${ANDROID_HOME}/build-tools/21.0.2/aapt &&\
#     rm -rf /opt/android-utils

##########################
##         final        ##
##########################
# Cleaning
RUN apt-get clean
# Use bash rather than dash
RUN rm /bin/sh && ln -s bash /bin/sh

WORKDIR $HOME
