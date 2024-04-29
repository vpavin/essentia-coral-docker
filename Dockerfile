FROM ubuntu:20.04

LABEL maintainer="Vini Pavin" \
      name="vpavin/essentia-coral-docker" \
      github="https://github.com/vpavin/essentia-coral-docker" \
      dockerhub="https://hub.docker.com/r/vpavin/essentia-coral" \
      org.opencontainers.image.authors="Vini Pavin" \
      org.opencontainers.image.source="https://github.com/vpavin/essentia-coral-docker"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV GASKET_GIT https://github.com/google/gasket-driver.git
ENV ESSENTIA_GIT https://github.com/MTG/essentia.git
ENV ESSENTIA_VERSION v2.1_beta5

WORKDIR /home

# Install dependencies and build gasket driver
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git debhelper devscripts dkms \
    && apt-get -y install linux-virtual \
    && git clone ${GASKET_GIT} \
    && cd gasket-driver/ \
    && debuild -us -uc -tc -b \
    && cd .. && dpkg -i gasket-dkms_1.0-18_*.deb \
    && apt-get update && apt-get upgrade -y

# Install essentia dependencies
RUN apt-get install -y \
    python3-matplotlib python3-numpy python3-six python3-yaml \
    libfftw3-3 libyaml-0-2 libtag1v5 libsamplerate0 \
    libavcodec58 libavformat58 libavutil56 libavresample4 \
    && rm -rf /var/lib/apt/lists/*

    RUN apt-get update \
    && apt-get install -y build-essential python3-dev git \
    libfftw3-dev libavcodec-dev libavformat-dev libavresample-dev \
    libsamplerate0-dev libtag1-dev libyaml-dev \
    && mkdir /essentia && cd /essentia && git clone ${ESSENTIA_GIT} \
    && cd /essentia/essentia && git checkout ${ESSENTIA_VERSION} \
    && python3 waf configure --with-python --with-examples --with-vamp \
    && python3 waf && python3 waf install && ldconfig \
    &&  apt-get remove -y build-essential libyaml-dev libfftw3-dev libavcodec-dev \
        libavformat-dev libavutil-dev libavresample-dev python-dev libsamplerate0-dev \
        libtag1-dev \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && cd / && rm -rf /essentia/essentia

ENV PYTHONPATH /usr/local/lib/python3/dist-packages

WORKDIR /essentia