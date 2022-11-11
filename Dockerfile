# Based on https://github.com/jfyne/docker-grpcwebproxy

FROM golang:alpine as builder

RUN apk --no-cache add git curl

RUN git clone https://github.com/improbable-eng/grpc-web.git $GOPATH/src/github.com/improbable-eng/grpc-web
RUN cd $GOPATH/src/github.com/improbable-eng/grpc-web && go install ./go/grpcwebproxy

FROM gcr.io/distroless/base-debian11

COPY --from=builder /go/bin/grpcwebproxy /grpcwebproxy

EXPOSE 8080 8443

CMD ["/grpcwebproxy"]
