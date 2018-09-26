FROM daocloud.io/library/python:3.6-alpine

MAINTAINER jinwen

# -- Install Pipenv:
ENV LANG=en_US.UTF-8 \
    TIME_ZONE=Asia/Shanghai


RUN set -ex && \
    echo 'https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main' > /etc/apk/repositories && \
    echo 'https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community' >> /etc/apk/repositories && \
    apk update

RUN pip install --upgrade pip && pip config set gloabl.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pipenv

# -- Install Application into container:
RUN set -ex && mkdir /app

WORKDIR /app

# -- Adding Pipfiles
ONBUILD COPY Pipfile Pipfile
ONBUILD COPY Pipfile.lock Pipfile.lock

# -- Install dependencies:
ONBUILD RUN set -ex && pipenv install --deploy --system

# -- Remove Pipenv
ONBUILD RUN pip uninstall -y pipenv


# --------------------
# - Using This File: -
# --------------------

# FROM kennethreitz/pipenv

# COPY . /app

# -- Replace with the correct path to your app's main executable
# CMD python3 main.py