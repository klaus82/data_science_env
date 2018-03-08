FROM continuumio/anaconda3

MAINTAINER klaus82 <cla.klaus@yahoo.it>

# update conda
RUN conda update -n base conda

# install TensorFlow
RUN conda install -c conda-forge tensorflow 

# install tflearn and keras: 
RUN pip install tflearn==0.3.2
RUN pip install keras==2.0.8

# install NLP packages:
RUN pip install nltk==3.2.4
RUN pip install gensim==2.3.0

# install Reinforcement Learning packages:
RUN pip install gym==0.9.4

# install jupyterlab
RUN pip install jupyterlab

# exposing port 8888
EXPOSE 8888

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD ["/opt/conda/bin/jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]



