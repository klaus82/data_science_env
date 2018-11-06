FROM continuumio/anaconda3

MAINTAINER klaus82 <cla.klaus@yahoo.it>

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "zsh"]
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN ["zsh"]

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

