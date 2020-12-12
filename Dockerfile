FROM golang:1.15.6-alpine as builder
RUN apk add --no-cache git
WORKDIR /workdir
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o webauthn-demo .

FROM alpine:3.12
WORKDIR /app
COPY --from=builder /workdir/webauthn-demo .
EXPOSE 8443
ENTRYPOINT ["/app/webauthn-demo", "-addr=0.0.0.0:8443"]
