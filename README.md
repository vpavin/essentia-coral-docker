# Containerized Essentia with Coral TPU support 
![example workflow](https://github.com/vpavin/essentia-coral-docker/actions/workflows/docker-publish.yml/badge.svg)

Docker image built on top of https://github.com/MTG/essentia-docker. This image also builds and install Gasket driver to allow usage of Google Coral TPU module (PCIe / m2).

To test if APEX module is loaded, run:

```shell
❯ docker run --device /dev/apex_0:/dev/apex_0 ghcr.io/vpavin/essentia-coral-docker ls /dev/apex_0
/dev/apex_0

```