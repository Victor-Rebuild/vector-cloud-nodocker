.PHONY: all go_deps vic-cloud vic-gateway clean

all: vic-cloud vic-gateway

go_deps:
	@echo `go version` && go mod download

vic-cloud: go_deps
	@mkdir -p build
	go build \
		-tags nolibopusfile,vicos \
		--trimpath \
		-ldflags '-w -s -linkmode internal -extldflags "-static" -r /anki/lib' \
		-o build/vic-cloud \
		cloud/main.go
	upx build/vic-cloud

vic-gateway: go_deps
	@mkdir -p build
	go build \
		-tags nolibopusfile,vicos \
		--trimpath \
		-ldflags '-w -s -linkmode internal -extldflags "-static" -r /anki/lib' \
		-o build/vic-gateway \
		gateway/*.go
	upx build/vic-gateway

clean:
	rm -rf build/

help:
	@echo "Available targets:"
	@echo "  all         - Build both vic-cloud and vic-gateway (default)"
	@echo "  vic-cloud   - Build vic-cloud only"
	@echo "  vic-gateway - Build vic-gateway only"
	@echo "  clean       - Remove build artifacts"
	@echo "  help        - Show this help message"
