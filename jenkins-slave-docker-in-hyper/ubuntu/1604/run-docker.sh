#!/bin/bash

/usr/bin/dockerd --host=tcp://0.0.0.0:2375 --host=unix:///var/run/docker.sock
