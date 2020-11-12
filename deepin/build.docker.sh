#!/usr/bin/env bash

#https://docs.docker.com/engine/reference/commandline/build/
#https://docs.docker.com/engine/reference/builder/#env
#https://docs.docker.com/engine/reference/builder/#arg
#https://docs.docker.com/engine/reference/builder/#environment-replacement
#https://peihsinsu.gitbooks.io/docker-note-book/content/dockerfile-env-vs-arg.html

# With the following build command, the proxy still will be used.
#sudo tcpdump -i any port 8080
#sudo tcpdump -i any port 18889

$ docker build --network host -f Dockerfiles/deepin . -t hongyi-zhao/deepin
$ docker build --network host -f Dockerfiles/deepin-wine . -t hongyi-zhao/deepin-wine

#sudo docker build -f amd64/Dockerfile . -t bestwu/deepin -t bestwu/deepin:lion -t bestwu/deepin:15.11
#sudo docker push hongyizhao/deepin
