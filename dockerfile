FROM alpine:3.8

MAINTAINER klaus82 <cla.klaus@yahoo.it>

# Build dependencies
RUN apk --update add --no-cache --virtual=build-dependencies wget ca-certificates bash

# Install Anaconda3 5.3.0
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda update --all --yes && \
    conda config --set auto_update_conda False && \
