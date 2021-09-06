# --- base -------------------------------------------------------------------
FROM golang:1.16.7-alpine AS base

WORKDIR /ayva
ENV GO111MODULE=on
ENV GOPATH="/go"
ENV PATH="$GOPATH/bin:$PATH"

RUN apk --update add --no-cache git ca-certificates shadow \
    && update-ca-certificates \
    && mkdir -p /home/dockeruser/perchfms/bin \
    && groupadd -r dockeruser \
    && useradd -r -g dockeruser dockeruser

COPY go.mod .
COPY go.sum .
RUN go mod download