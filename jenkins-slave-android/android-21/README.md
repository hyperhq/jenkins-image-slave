hyperhq/jenkins-slave-android:android-21
========================================

This is a Jenkins slave image based on `ubuntu:14.04`.

It contains:
- oracle-java8
- `android sdk:r24.4.1`
  - android-21
  - build-tools-21.0.2
- `gradle:3.1`
- `maven:3.3.9`
- `ant:1.9.7`
- jenkins slave(REF: [jenkinsci/slave](https://hub.docker.com/r/jenkinsci/slave/))

Usage: `./build.sh`
