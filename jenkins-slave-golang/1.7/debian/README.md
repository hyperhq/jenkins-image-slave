hyperhq/jenkins-slave-golang
============================

This is a jenkins slave image for build golang project, the base image is `openjdk:8-jdk`.
It contains:
- debian:8.5(jessie)
- oracle-jdk8
- golang:1.7
- jenkins slave(REF: [jenkinsci/slave](https://hub.docker.com/r/jenkinsci/slave/))

Usage: `./build.sh`
