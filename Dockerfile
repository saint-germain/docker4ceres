# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM python:2

USER root

VOLUME /tmp/.X11-unix /tmp/.X11-unix rw
RUN mkdir -p /opt/work
WORKDIR /opt/work
COPY ./requirements.txt /opt/work/

RUN pip install -r requirements.txt

RUN apt-get update && \
    apt-get install -y gfortran x11-apps x11-xserver-utils && \
    apt-get install -y g++ && \
    apt-get install -y swig && \
    apt-get install -y libgsl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/nataliaalvarezb/ceres
EXPOSE 8888
CMD ["jupyter", "lab", "--ip='0.0.0.0'", "--port=8888", "--NotebookApp.token=''", "--no-browser", "--allow-root"]
