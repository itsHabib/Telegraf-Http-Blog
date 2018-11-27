FROM golang:alpine as builder

RUN apk update && apk add git
COPY . $GOPATH/src/app
WORKDIR $GOPATH/src/app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server main.go

# Execute Binary 
FROM alpine:3.7
WORKDIR /root
COPY --from=builder /go/src/app/server .
EXPOSE 8010
CMD ["./server"]
