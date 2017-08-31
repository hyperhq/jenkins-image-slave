#!/bin/bash

/usr/bin/dockerd-current \
          --add-runtime docker-runc=/usr/libexec/docker/docker-runc-current \
          --host=unix:///var/run/docker.sock \
          --host=tcp://0.0.0.0:2375 \
          --default-runtime=docker-runc \
          --userland-proxy-path=/usr/libexec/docker/docker-proxy-current
