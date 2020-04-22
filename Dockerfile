FROM golang:1.14.2-alpine3.11 as builder
ENV GOPATH /go
ENV VEGETA_COMMIT_HASH d9b795a
ENV VEGETA_REPO github.com/tsenart/
RUN apk update && apk add git
RUN mkdir -p ${GOPATH}/src/${VEGETA_REPO} ${GOPATH}/bin
WORKDIR ${GOPATH}/src/${VEGETA_REPO}
RUN git clone https://${VEGETA_REPO}vegeta
WORKDIR ${GOPATH}/src/${VEGETA_REPO}vegeta
RUN git checkout ${VEGETA_COMMIT_HASH}
RUN go build -o ${GOPATH}/bin/vegeta

FROM alpine:3.11
COPY --from=builder /go/bin/vegeta /usr/bin/vegeta
