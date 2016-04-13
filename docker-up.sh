#!/bin/bash

docker run -d --name dockgit \
    -p 2332:22 \
    -v /data/dockgit/repos:/repos \
    dockgit
