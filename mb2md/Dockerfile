FROM debian:jessie
MAINTAINER Stewart V. Wright <stewart@vifortech.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        mb2md && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
