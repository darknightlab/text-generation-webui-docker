# text-generation-webui-docker

text-generation-webui-docker

```bash
cd src
ln -s docker/{Dockerfile,docker-compose.yml,.dockerignore} .
cp docker/.env.example .env
vim docker-compose.yml # add image: text-generation-webui:latest
# Edit .env and set TORCH_CUDA_ARCH_LIST based on your GPU model
vim .env
docker compose build
cd ..
cp src/.env .env

```
