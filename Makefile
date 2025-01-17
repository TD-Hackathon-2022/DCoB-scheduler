.PHONY: all
all: clean dev

dev: fmt check gen-api test

fmt:
	go fmt ./...

check:
	staticcheck .

build:
	go build

linuxbuild:
	GOOS=linux GOARCH=amd64 go build

test:
	go test -tags=test ./...

clean:
	go clean -i -r -testcache -cache

gen-api:
	protoc -I=./api --go_out=. ./api/api.proto

package: linuxbuild
		docker build -t hydezhao/scheduler:latest .