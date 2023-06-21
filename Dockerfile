FROM text-generation-webui:latest

WORKDIR /app

RUN . /app/venv/bin/activate && pip3 install xformers

ENV CLI_ARGS=""
CMD . /app/venv/bin/activate && python3 server.py ${CLI_ARGS}