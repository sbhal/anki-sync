FROM rust AS build
LABEL org.opencontainers.image.source="https://github.com/sbhal/anki-sync"

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /build

RUN apt-get update
RUN apt-get install --yes protobuf-compiler
ENV PROTOC=/usr/bin/protoc
RUN --mount=type=cache,target=/app/target/ \
    --mount=type=cache,target=/usr/local/cargo/registry/

RUN set -e
RUN cargo install --git https://github.com/ankitects/anki.git --tag 2.1.66 anki-sync-server


FROM debian:stable-slim AS final

COPY --from=build /usr/local/cargo/bin/anki-sync-server /

RUN apt-get update
RUN apt-get install --yes curl

HEALTHCHECK --interval=30s --timeout=3s CMD curl localhost:8080 || exit 1

EXPOSE 8080

ENTRYPOINT ["/anki-sync-server"]
