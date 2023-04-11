ARG GO_VERSION=1.20
FROM golang:${GO_VERSION}-alpine as builder
ARG CGO_ENABLED=0 GOOS=linux GOARCH=amd64
WORKDIR /build
COPY src/main .
RUN go build -o /api main.go

FROM gcr.io/distroless/static
USER nonroot:nonroot
COPY --from=builder api /bin/api
EXPOSE 8080
ENTRYPOINT ["/bin/api"]