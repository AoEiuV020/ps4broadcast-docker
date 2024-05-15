#!/bin/sh
. "$(dirname $0)/env.sh"
docker buildx build -t "$IMAGE_NAME" "--platform=$PLATFORM" "$ROOT"