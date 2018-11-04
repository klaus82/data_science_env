FROM debian:latest

MAINTAINER klaus82 <cla.klaus@yahoo.it>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# update conda
RUN conda update -n base conda

# install TensorFlow
RUN conda install -c conda-forge tensorflow 

# install tflearn and keras: 
RUN pip install tflearn==0.3.2
RUN pip install keras==2.1.5

# install NLP packages:
RUN pip install nltk==3.2.5
RUN pip install gensim==3.4.0

# install Reinforcement Learning packages:
RUN pip install gym

# install jupyterlab
RUN pip install jupyterlab

# exposing port 8888
EXPOSE 8888

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD ["/opt/conda/bin/jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]

