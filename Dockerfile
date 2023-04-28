FROM ubuntu:20.04

LABEL Maintainer="Gaurav Singh"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update  -y \
    && apt-get upgrade -y \
    && apt-get install -y asciidoc binutils build-essential \
       curl dbus default-jre doxygen expat \
       git googletest graphviz libboost-all-dev libdbus-1-dev \
       libdbus-c++-dev libdbus-glib-1-dev libexpat-dev \
       libgtest-dev libtool make maven ninja-build python3 python3-dev \
       python3-distutils python3-pip tar wget \
    && python3 -m pip install pytest pybind11 jsonschema

RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3-linux-x86_64.sh -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /opt/cmake-3.26.3 \
    && /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake-3.26.3 \
    && rm /tmp/cmake-install.sh \
    && ln -s /opt/cmake-3.26.3/bin/* /usr/local/bin

RUN apt-get install -y gdb

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

