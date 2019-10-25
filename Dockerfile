FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y vim htop git python python-pip \
    && mkdir -p /root/.config/pip \
    && echo '[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple' > /root/.config/pip/pip.conf
