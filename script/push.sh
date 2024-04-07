#!/bin/sh
. "$(dirname $0)/env.sh"
username=$DOCKER_ID
if test -z $username
then
    echo docker login first
    exit 2
fi
docker build -t "$IMAGE_NAME" "$ROOT"
docker_push()
{
    docker tag "$IMAGE_NAME" "$username/$IMAGE_NAME:$1"
    docker push "$username/$IMAGE_NAME:$1"
}
for i in $*
do
    docker_push $i
done
docker_push latest