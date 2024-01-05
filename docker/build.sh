#!/bin/bash

CONTAINER_REGISTRY=lscsandboxsdeacr.azurecr.io
TAG_NAME=sandbox
PUSH_IMAGES=0

while getopts ":rp" o; do
    case "${o}" in
        r)
            CONTAINER_REGISTRY=${OPTARG}
            ;;
        p)
            PUSH_IMAGES=1
            ;;
    esac
done


for IMAGE_NAME in $(cat config.json | jq '.images[].name' -r)
do
    echo "Building ${IMAGE_NAME}"
    IMAGE_CATEGORY=$(cat config.json | jq ".images[] | select(.name == \"${IMAGE_NAME}\") | .category" -r)
    BASE_IMAGE=$(cat config.json | jq ".images[] | select(.name == \"${IMAGE_NAME}\") | .baseImage" -r)
    
    if [ "${BASE_IMAGE}" != "null" ]; then
        echo "dsa"
        docker build "./${IMAGE_NAME}/" -t "${CONTAINER_REGISTRY}/lsc-sde/${IMAGE_CATEGORY}/${IMAGE_NAME}:${TAG_NAME}" --build-arg BASE_CONTAINER="${CONTAINER_REGISTRY}/lsc-sde/${IMAGE_CATEGORY}/${BASE_IMAGE}:${TAG_NAME}"
    else
        echo "sad"
        docker build "./${IMAGE_NAME}/" -t "${CONTAINER_REGISTRY}/lsc-sde/${IMAGE_CATEGORY}/${IMAGE_NAME}:${TAG_NAME}"
    fi

    if [ $PUSH_IMAGES == 1 ]; then
        docker push "${CONTAINER_REGISTRY}/lsc-sde/${IMAGE_CATEGORY}/${IMAGE_NAME}:${TAG_NAME}"
    fi
done