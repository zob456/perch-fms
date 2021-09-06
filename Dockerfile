FROM golang:1.17-alpine

COPY api/main.go src/perchfms/api/main.go
COPY go.mod  src/perchfms/go.mod
COPY go.sum src/perchfms/go.sum

WORKDIR /go/src/perchfms/api/
RUN CGO_ENABLED=0 GOOS=linux GARCH=amd64 go build -installsuffix cgo -o build/api .

CMD ["./build/api"]
EXPOSE 8000