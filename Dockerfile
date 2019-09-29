FROM ubuntu:16.04

MAINTAINER Dockerfiles

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    libkrb5-dev \
	git \
	python3 \
	python3-dev \
	python3-setuptools \
	python3-pip \
	nginx \
	vim \
	supervisor \
	curl && \
	pip3 install -U pip setuptools && \
    rm -rf /var/lib/apt/lists/*

# install uwsgi now because it takes a little while
RUN pip3 install uwsgi

COPY . /rest-framework-tutorial/
RUN pip3 install -r /rest-framework-tutorial/requirements.txt

COPY supervisor-app.conf /etc/supervisor/conf.d/

WORKDIR /rest-framework-tutorial/

ENV LANG C.UTF-8
ENV LANGUAGE zh-cn:zh
ENV LC_ALL C.UTF-8