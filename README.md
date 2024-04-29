# Containerized Essentia with Coral TPU support 

Docker image built on top of https://github.com/MTG/essentia-docker. This image also builds and install Gasket driver to allow usage of Google Coral TPU module (PCIe / m2).

To test if APEX module is loaded, run:

```shell
❯ docker run --device /dev/apex_0:/dev/apex_0 vpavin/essentia-coral:latest ls /dev/apex_0
/dev/apex_0

```