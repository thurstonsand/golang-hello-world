BINARY=hello-world

all: fmt build test

fmt:
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
	docker build .