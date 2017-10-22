hyperhq/jenkins-image-slave:go1.8-centos7-mgo
========================================

This is a jenkins slave image for build golang project, the base image is `hyperhq/jenkins-image-slave:go1.8-centos7`.
It contains:
- oracle-jdk8
- golang:1.7
- mongo:3.2
- jenkins slave(REF: [jenkinsci/slave](https://hub.docker.com/r/jenkinsci/slave/))

Usage: `./build.sh`


>When use "Execute shell" in build step, please add the following lines
```
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
```
