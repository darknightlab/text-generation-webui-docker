FROM text-generation-webui:latest

# nvidia environment
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && apt-get install -y wget libaio-dev gcc linux-headers-$(uname -r) && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && apt-get update && \
    apt-get install -y --no-install-recommends cuda && \
    . /app/venv/bin/activate && pip3 install xformers deepspeed && \
    apt-get remove cuda && apt autoremove && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES=
ENV NVIDIA_DRIVER_CAPABILITIES=
ENV DEBIAN_FRONTEND=

ENV CLI_ARGS=""
# CMD . /app/venv/bin/activate && python3 server.py ${CLI_ARGS}
CMD . /app/venv/bin/activate && deepspeed --num_gpus 1 server.py --deepspeed ${CLI_ARGS}