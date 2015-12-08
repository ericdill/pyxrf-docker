
# build with 'docker build -t mc3 .
# run with 'docker run -i -t mc3 /bin/bash'
FROM ubuntu:latest

MAINTAINER Eric Dill <edill@bnl.gov>

RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    gcc \
    mongodb \
    dh-autoreconf \
    vim \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi

RUN echo 'export PATH=/opt/conda/bin:$PATH' > ~/.bashrc && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.10.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.10.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.10.1-Linux-x86_64.sh
ENV CONDA=/opt/conda/bin/conda
ENV PYTHON=/opt/conda/bin/python
ENV ANACONDA=/opt/conda/bin/anaconda

# install packages for turning this docker instance into a binstar worker
RUN $CONDA install -y \
    anaconda-build \
    anaconda-client \
    conda-build

RUN $CONDA config --add channels scikit-xray

RUN $CONDA config --add channels licode

RUN $CONDA install pyxrf --yes

RUN echo 'export PATH="/opt/conda/bin:$PATH"' >> ~/.bashrc

#RUN source ~/.bashrc
