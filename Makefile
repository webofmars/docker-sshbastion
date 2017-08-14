all: deps build

clean:
	rm -rf dist/*

deps: dist dist/s6-overlay-amd64.tar.gz dist/confd-0.12.0-linux-amd64

# files to retrieve
dist:
	mkdir -p dist

dist/s6-overlay-amd64.tar.gz:
	wget -O dist/s6-overlay-amd64.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz
	touch $@

dist/confd-0.12.0-linux-amd64:
	wget -O dist/confd-0.12.0-linux-amd64 https://github.com/kelseyhightower/confd/releases/download/v0.12.0/confd-0.12.0-linux-amd64
	touch $@

# build docker image
build:
	docker build -t webofmars/sshbastion:develop .
