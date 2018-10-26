TAG ?= latest

.PHONY: image
image:
	docker build -t quay.io/signalfx/istio-adapter:$(TAG) .
