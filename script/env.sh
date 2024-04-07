#!/bin/sh
set -e
script_dir=$(cd $(dirname $0);pwd)
ROOT=$(dirname $script_dir)
IMAGE_NAME=ps4broadcast
CONTAINER_NAME=ps4b
DOCKER_ID=aoeiuv020