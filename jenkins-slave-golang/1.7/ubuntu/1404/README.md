hyperhq/jenkins-slave-golang
============================

This is a jenkins slave image for build golang project, the base image is `ubuntu:14.04`.
It contains:
- oracle-jdk8
- golang:1.7
- jenkins slave(REF: [jenkinsci/slave](https://hub.docker.com/r/jenkinsci/slave/))

Usage: `./build.sh`


>When use "Execute shell" in build step, please add the following lines
```
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
```
