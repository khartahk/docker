---
# Build tailscale Docker image and publis to ghcr.io

This repo checks for new tags on github.com/tailscale/tailscale and builds
docker image when new release comes out automaticaly.

It publishes Docker image to ghcr.io and tags according to upstream.

