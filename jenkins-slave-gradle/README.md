Building Java Projects with Gradle: `hyperhq/jenkins-slave-gradle`
==================================================================

This is a jenkins slave image for build project with gradle, the base image is `java:8-jdk`.

# Dependency
- oracle-jdk:1.8

# Config job

## Config General
```
Run the build inside Hyper_ container
  -> Docker Image: hyperhq/jenkins-slave-gradle
  -> Container Size: S4
```

## Config Source Code Management
```
Git
  -> Repositories -> Repository URL: https://github.com/pkainulainen/gradle-examples.git
```

## Config build step

### add Execute shell
```
cd $WORKSPACE/integration-tests/
/gradlew clean test integrationTest
```

## Trigger build

## View build result
