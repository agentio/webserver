FROM golang:1.26.4 AS builder
WORKDIR /app
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -v -o web-server .

FROM alpine:3
RUN apk add --no-cache ca-certificates
COPY --from=builder /app/web-server /web-server
CMD ["/web-server"]
