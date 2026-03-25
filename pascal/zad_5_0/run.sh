#!/bin/bash
IMAGE_NAME="pascal-app"
docker build -t $IMAGE_NAME .
docker run --rm $IMAGE_NAME
read -p "Nacisnij Enter, aby wyjść."