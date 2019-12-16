#!/bin/bash

COMMIT_HASH=HEAD
IMAGE_NAME=headless-obyte
IMAGE_VERSION=$IMAGE_NAME:$COMMIT_HASH
IMAGE_LATEST=$IMAGE_NAME:latest
CONTAINER_NAME=headless-obyte

if [ ! "$(docker images -q $IMAGE_VERSION)" ]; then 
	
	echo "Building image $IMAGE_VERSION. Press Ctrl-C to abort, press Enter to continue..."
	read

	docker build -t $IMAGE_LATEST -t $IMAGE_VERSION --build-arg COMMIT=$COMMIT_HASH .

fi

echo "Running container $CONTAINER_NAME. Press Ctrl-P Ctrl-Q to exit the container"
docker run -it --rm --name $CONTAINER_NAME -v $CONTAINER_NAME-data:/obyte -p 6332:6332 $IMAGE_LATEST

