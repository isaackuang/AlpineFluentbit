FROM isaackuang/alpine-base:3.8.0 as build

# apk add --virtual mypacks

RUN apk --no-cache --progress --virtual mypacks add gcc g++ make cmake musl-dev && \
    cd /tmp && \
    wget https://fluentbit.io/releases/0.14/fluent-bit-0.14.4.tar.gz && \
    tar zxvf fluent-bit-0.14.4.tar.gz && \
    cd fluent-bit-0.14.4/build && \
    cmake .. && make

FROM isaackuang/alpine-base:3.8.0

RUN apk --no-cache --progress add libgcc

COPY --from=build /tmp/fluent-bit-0.14.4/build/bin/fluent-bit /usr/bin/fluent-bit

COPY config /
