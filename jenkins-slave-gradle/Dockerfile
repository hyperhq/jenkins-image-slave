FROM java:8-jdk
MAINTAINER Jimmy Xu <jimmy@hyper.sh>

ADD gradlew .
ADD gradle gradle/
RUN ./gradlew
#RUN rm -rf gradlew; rm -rf gradle
