FROM node:6.10.3

RUN mkdir /code

WORKDIR /code

RUN apt-get update && apt-get -y install zip
