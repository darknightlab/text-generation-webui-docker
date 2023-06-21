FROM text-generation-webui:latest

WORKDIR /app

RUN . /app/venv/bin/activate && pip3 install xformers deepspeed && \
    apt-get update && apt-get install -y libaio-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV CLI_ARGS=""
# CMD . /app/venv/bin/activate && python3 server.py ${CLI_ARGS}
CMD . /app/venv/bin/activate && deepspeed --num_gpus 1 server.py --deepspeed ${CLI_ARGS}