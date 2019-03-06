.PHONY: tor-daemon

build:
	go build -o tor-controller-manager cmd/controller-manager/main.go
	go build -o tor-local-manager cmd/tor-local-manager/main.go

tor-daemon-manager_docker:
	docker build . -f Dockerfile.tor-daemon-manager -t nishedcob/tor-daemon-manager:master

tor-controller_docker:
	docker build . -f Dockerfile.controller -t nishedcob/tor-controller-manager:master

images: tor-daemon_docker tor-controller_docker

install.yaml:
	kubebuilder create config --name=tor --controller-image=nishedcob/tor-controller-manager:master --output=hack/install.yaml
