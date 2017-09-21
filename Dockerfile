FROM postgres:9.6

RUN useradd -ms /bin/bash stolon

EXPOSE 5432

ARG VERSION=v0.7.0

ADD https://github.com/sorintlab/stolon/releases/download/${VERSION}/stolon-${VERSION}-linux-amd64.tar.gz /tmp/stolon.tar.gz

RUN tar -xf /tmp/stolon.tar.gz stolon-${VERSION}-linux-amd64/bin \
    && mv stolon-${VERSION}-linux-amd64/bin/stolon* /usr/local/bin/ \
    && rm -r stolon* && rm /tmp/stolon.tar.gz

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential python3 python3-pip python3-dev lzop pv \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install wal-e[google]
