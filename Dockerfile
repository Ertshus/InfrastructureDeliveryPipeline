# syntax=docker/dockerfile:1

# Builder stage
FROM python:3.10-alpine AS builder

WORKDIR /code

COPY requirements.txt /code
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

COPY . /code

# Entrypoint and CMD for the builder stage
ENTRYPOINT ["python3"]
CMD ["app.py"]

# Dev Env stage
FROM builder as dev-envs

# Install additional packages in the dev-envs stage
RUN apk update && \
    apk add git bash

# Create a group and user
RUN addgroup -S docker && \
    adduser -S --shell /bin/bash --ingroup docker vscode

# Copy from an external image (replace "gloursdocker/docker" with the correct image)
COPY --from=gloursdocker/docker / /
