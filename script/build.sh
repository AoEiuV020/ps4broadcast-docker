#!/bin/sh
. "$(dirname $0)/env.sh"
docker build -t "$IMAGE_NAME" "$ROOT"