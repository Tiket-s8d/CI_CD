FROM alpine:3.14


RUN apk add --no-cache cmake \
 gcc-arm-none-eabi \
 git \ 
 make \ 
 doxygen \
 py3-sphinx \
 py3-sphinx_rtd_theme \
 py3-breathe \
 newlib \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /home
COPY ./ ./
CMD ["sh", "-c", "while true; do sleep 1; done"]

