
FROM ubuntu:16.04

MAINTAINER Khelil Sator <ksator@juniper.net> 

ADD . /

WORKDIR /

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y python-pip


RUN pip install -r requirements.txt



ENTRYPOINT sh ./microservice_collect_junos_configuration.sh 
