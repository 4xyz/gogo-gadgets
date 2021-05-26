FROM alpine:latest

ENV USER=4xyz \
    UID=9999 \
    GID=9999

RUN apk update && \
    apk upgrade && \
    apk add bash && \
    apk add terraform --repository=http://dl-cdn.alpinelinux.org/alpine/v3.12/main && \
    mkdir /opt/terraform
RUN addgroup -g $GID $USER && \
    adduser \
    --disabled-password \
    --gecos "" \
    --home /home/$USER \
    --ingroup "$USER" \
    --uid "$UID" \
    "$USER" && \
    chown -R $USER:$USER /opt/terraform

WORKDIR /opt/terraform
USER 4xyz
