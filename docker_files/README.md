# Directory with docker files to create the containers

## Dockerfiles description

Below is a brief description of the docker files in this directory

1. Dockerfile.mcs	- Creates a single instance of Columnstore
2. Dockerfile.mxscl	- Creates a MaxScale image
3. Dockerfile.python - Creates a client container with Python installed
4. Dockerfile.srv	- Creates a MariaDB server image

## Build a Image

To build the images you need to change directories to the in you Docker registry run the following commands: 

1. For Columnstore - __$ docker build --rm -t mdbax4 - < Dockerfile.mcs__
2. For MaxScale - __$ docker build --rm -t mdbmxscl - < Dockerfile.mxscl__	
3. For the Python client - __$ docker build --rm -t py - < Dockerfile.python__
4. For the MariaDB server - __$ docker build --rm -t mdbsrv - < Dockerfile.srv__

To validate the images were created run:

__$ docker images__

## Launch a container

If you want to test the image you can launch the container manually with the followin commands

$ docker run --privileged --name <container name> --hostname <container name>  -it -d <image name above>:latest

