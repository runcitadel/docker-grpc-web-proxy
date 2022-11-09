# Based on https://github.com/jfyne/docker-grpcwebproxy

FROM golang:alpine as builder

RUN apk --no-cache add git curl

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

RUN git clone https://github.com/improbable-eng/grpc-web.git $GOPATH/src/github.com/improbable-eng/grpc-web
RUN cd $GOPATH/src/github.com/improbable-eng/grpc-web && dep ensure && go install ./go/grpcwebproxy

FROM alpine

RUN apk --no-cache add ca-certificates

WORKDIR /

COPY --from=builder /go/bin/grpcwebproxy .

EXPOSE 8080 8443

CMD ["/grpcwebproxy"]
