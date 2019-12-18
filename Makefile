BINARY=hello-world

all: fmt build test

fmt:
	@go list -m -f '{{.Dir}}' github.com/golangci/golangci-lint 1>/dev/null 2>&1 || go mod download
	go run $$(go list -m -f '{{.Dir}}' github.com/golangci/golangci-lint)/cmd/golangci-lint/main.go run

test:
	go test -v ./...

build:
	go build -o bin/$(BINARY) -v cmd/hello/main.go

clean:
	go clean 
	rm -rf bin

run: build
	bin/$(BINARY)

docker-build:
	sudo docker build . --tag=golang-hello-world:latest