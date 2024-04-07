#!/bin/sh
. "$(dirname $0)/env.sh"
docker run --rm -p 26666:26666 -p 1935:1935 -p 6667:6667 -it --entrypoint bash --name $CONTAINER_NAME $IMAGE_NAME