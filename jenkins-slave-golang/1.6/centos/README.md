hyperhq/jenkins-slave-golang
============================

This is a jenkins slave image for build golang project, the base image is `centos:7.2.1511`.
It contains:
- openjdk:1.8
- golang:1.6
- jenkins slave(REF: [jenkinsci/slave](https://hub.docker.com/r/jenkinsci/slave/))

Usage: `./build.sh`


>When use "Execute shell" in build step, please add the following lines
```
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
```
