FROM quay.io/pypa/manylinux1_x86_64

MAINTAINER Giacomo Vianello <giacomov@stanford.edu>

# Explicitly become root (even though likely we are root already)
USER root

# Install some needed packages
RUN yum install -y blas blas-devel lapack lapack-devel

# Override the default shell (sh) with bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Create work directory
RUN mkdir /work

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh

RUN chmod u+x Miniconda2-latest-Linux-x86_64.sh

# -b is for batch mode

RUN ./Miniconda2-latest-Linux-x86_64.sh -b -p /work/miniconda2

RUN rm -rf Miniconda2-latest-Linux-x86_64.sh

# Copy the copy for xspec-modelsonly
COPY xspec-modelsonly-v6.20-no-big-data.tar.gz /work

# Copy the script for building everything
COPY build_xspec-modelsonly.sh /work
COPY build_3ML.sh /work

RUN chmod u+x /work/build_xspec-modelsonly.sh 
RUN chmod u+x /work/build_3ML.sh

# Install wheel2conda
RUN /opt/python/cp36-cp36m/bin/pip install wheel2conda

ENV CONDA_ENV=/work/miniconda2
ENV WHEEL2CONDA=/opt/python/cp36-cp36m/bin/wheel2conda

WORKDIR /work

