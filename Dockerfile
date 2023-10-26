FROM docker.io/ubuntu:22.04 AS build

ARG DEBIAN_FRONTEND=noninteractive
ARG MICMAC_PATH=/etc/opt/micmac
ARG MICMAC_VERSION=v1.1.1

RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \ 
    git \
    libx11-dev \
    make \
    xorg \
    && rm -rf /var/lib/apt/lists/*
WORKDIR ${MICMAC_PATH}
RUN git clone --depth 1 --branch ${MICMAC_VERSION} https://github.com/micmacIGN/micmac.git ${MICMAC_PATH} && \
    cmake . && \
    make install -j8

FROM docker.io/ubuntu:22.04 AS micmac

ARG DEBIAN_FRONTEND=noninteractive
ARG MICMAC_PATH=/etc/opt/micmac

RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
    make \
    imagemagick \
    libimage-exiftool-perl \
    exiv2 \
    proj-bin \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build "${MICMAC_PATH}/bin/" "${MICMAC_PATH}/bin/"
COPY --from=build "${MICMAC_PATH}/include/XML_GEN" "${MICMAC_PATH}/include/XML_GEN"
COPY --from=build "${MICMAC_PATH}/include/XML_MicMac" "${MICMAC_PATH}/include/XML_MicMac"
COPY --from=build "${MICMAC_PATH}/binaire-aux/linux/" "${MICMAC_PATH}/binaire-aux/linux/"
ENV PATH="${MICMAC_PATH}/bin/:${PATH}"

WORKDIR /data
USER 1000
