# CPCTelera docker image

## Disclaimer

This is not an official docker image of CPCTelera (https://github.com/lronaldo/cpctelera)

## Usage

This image contains all dependencies and source from https://github.com/lronaldo/cpctelera

docker image https://hub.docker.com/r/paugp/cpct-docker

Folder structure are:

- /cpct-data : content of https://github.com/lronaldo/cpctelera
- /data : Workdir

Default command is `make` over /data folder 

`docker run -it --rm -v path-to-project:/data cpct-docker:latest`

You can directly override command just passing by parameter. (Ex. `make clean all`) 

`docker run -it --rm -v path-to-project:/data cpct-docker:latest make clean all`

Alternatively you can direclty run bash to run and interactive terminal

`docker run -it --rm -v path-to-project:/data cpct-docker:latest bash`

## Build your own image

`docker build .`