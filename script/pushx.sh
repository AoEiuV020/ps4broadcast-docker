#!/bin/sh
. "$(dirname $0)/env.sh"
username=$DOCKER_ID
if test -z $username
then
    echo docker login first
    exit 2
fi
docker_push()
{
    docker buildx build -t "$username/$IMAGE_NAME:$1" "--platform=$PLATFORM" --push "$ROOT"
}
for i in $*
do
    docker_push $i
done
docker_push latest