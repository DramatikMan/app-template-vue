#!/bin/bash
docker run \
    --rm \
    -p "3001:8080" \
    --name app-template-vue \
    app-template-vue:latest
