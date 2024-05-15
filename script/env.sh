#!/bin/sh
set -e
script_dir=$(cd $(dirname $0);pwd)
ROOT=$(dirname $script_dir)
IMAGE_NAME="${IMAGE_NAME:-ps4broadcast}"
CONTAINER_NAME="${CONTAINER_NAME:-ps4b}"
DOCKER_ID="${DOCKER_ID:-aoeiuv020}"
PLATFORM="${PLATFORM:-linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x}"