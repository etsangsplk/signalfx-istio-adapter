FROM golang:1.11.1 as builder

WORKDIR /go/src/github.com/signalfx/signalfx-istio-adapter/
COPY ./ ./
RUN mkdir -p ./bin &&\
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -v -o bin/signalfx-istio-adapter ./cmd

FROM scratch

ENTRYPOINT ["/signalfx-istio-adapter"]
CMD ["8080"]
EXPOSE 8080
COPY --from=builder /go/src/github.com/signalfx/signalfx-istio-adapter/bin/signalfx-istio-adapter /
