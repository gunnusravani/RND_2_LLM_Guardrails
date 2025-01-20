#! /bin/bash

docker run -it \
 --gpus all \
 --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 \
 --rm \
 --mount type=bind,source="$(pwd)",target=/home/ \
 -p 10503:10503 \
 --name jailbreak \
 -d \
 sravani/experiment1 \
 jupyter notebook --port 10503 --ip '0.0.0.0' --allow-root --NotebookApp.token=1234
 