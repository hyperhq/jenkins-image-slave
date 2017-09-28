#!/bin/bash

/entrypoint.sh

/usr/bin/dockerd \
          --add-runtime docker-runc=/usr/libexec/docker/docker-runc \
          --host=unix:///var/run/docker.sock \
          --host=tcp://0.0.0.0:2375 \
          --default-runtime=docker-runc \
          --userland-proxy-path=/usr/libexec/docker/docker-proxy
