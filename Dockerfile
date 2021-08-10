# Stage 1: Build executable
FROM golang:1.16.6-alpine3.14 as buildImage

ENV GO111MODULE=on

RUN apk add --no-cache ca-certificates curl git

WORKDIR /go/src/webpagetest-prometheus-exporter
COPY . .

RUN CGO_ENABLED=0 \
  GOOS=`go env GOHOSTOS` \
  GOARCH=`go env GOHOSTARCH` \
  go build -v -o build


# Stage 2: Create release image
FROM alpine:3.14

RUN mkdir app
WORKDIR app

RUN apk --no-cache add ca-certificates

COPY --from=buildImage /go/src/webpagetest-prometheus-exporter/build exporter
EXPOSE 3030
ENTRYPOINT [ "/app/exporter" ]
