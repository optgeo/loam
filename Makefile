# Makefile for exploring OpenAerialMap S3 bucket
# OpenAerialMap bucket: s3://oin-hotosm-temp/

# AWS CLI settings
AWS := aws --no-sign-request --endpoint-url https://s3.us-east-1.amazonaws.com
BUCKET := s3://oin-hotosm-temp/

# Default target
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@echo "OpenAerialMap S3 Bucket Explorer"
	@echo "================================="
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

.PHONY: list
list: ## List all contents of the bucket (recursive)
	$(AWS) s3 ls $(BUCKET) --recursive --human-readable --summarize

.PHONY: list-top
list-top: ## List top-level directories in the bucket
	$(AWS) s3 ls $(BUCKET)

.PHONY: list-path
list-path: ## List contents of a specific path (usage: make list-path PATH_PREFIX=<path>)
	@if [ -z "$(PATH_PREFIX)" ]; then \
		echo "Error: PATH_PREFIX is required. Usage: make list-path PATH_PREFIX=59b736a823c8440011d7b0c4/"; \
		exit 1; \
	fi
	$(AWS) s3 ls $(BUCKET)$(PATH_PREFIX) --recursive --human-readable

.PHONY: show-meta
show-meta: ## Show metadata JSON file (usage: make show-meta FILE=<path>)
	@if [ -z "$(FILE)" ]; then \
		echo "Error: FILE is required. Usage: make show-meta FILE=59b736a823c8440011d7b0c4/0/ea9a7c9d-dac9-4350-94ae-ff37c67a65d9_meta.json"; \
		exit 1; \
	fi
	$(AWS) s3 cp $(BUCKET)$(FILE) - | jq .

.PHONY: download-meta
download-meta: ## Download metadata JSON file (usage: make download-meta FILE=<path> OUTPUT=<filename>)
	@if [ -z "$(FILE)" ]; then \
		echo "Error: FILE is required. Usage: make download-meta FILE=59b736a823c8440011d7b0c4/0/ea9a7c9d-dac9-4350-94ae-ff37c67a65d9_meta.json OUTPUT=meta.json"; \
		exit 1; \
	fi
	@if [ -z "$(OUTPUT)" ]; then \
		echo "Error: OUTPUT is required. Usage: make download-meta FILE=59b736a823c8440011d7b0c4/0/ea9a7c9d-dac9-4350-94ae-ff37c67a65d9_meta.json OUTPUT=meta.json"; \
		exit 1; \
	fi
	$(AWS) s3 cp $(BUCKET)$(FILE) $(OUTPUT)
	@echo "Downloaded to $(OUTPUT)"

.PHONY: download-file
download-file: ## Download any file from the bucket (usage: make download-file FILE=<path> OUTPUT=<filename>)
	@if [ -z "$(FILE)" ]; then \
		echo "Error: FILE is required. Usage: make download-file FILE=<path> OUTPUT=<filename>"; \
		exit 1; \
	fi
	@if [ -z "$(OUTPUT)" ]; then \
		echo "Error: OUTPUT is required. Usage: make download-file FILE=<path> OUTPUT=<filename>"; \
		exit 1; \
	fi
	$(AWS) s3 cp $(BUCKET)$(FILE) $(OUTPUT)
	@echo "Downloaded to $(OUTPUT)"

.PHONY: gdalinfo
gdalinfo: ## Show GDAL info for a GeoTIFF file (usage: make gdalinfo FILE=<local-file>)
	@if [ -z "$(FILE)" ]; then \
		echo "Error: FILE is required. Usage: make gdalinfo FILE=<local-file.tif>"; \
		exit 1; \
	fi
	@if ! command -v gdalinfo >/dev/null 2>&1; then \
		echo "Error: gdalinfo not found. Please install gdal-bin"; \
		exit 1; \
	fi
	gdalinfo $(FILE)

.PHONY: gdalinfo-remote
gdalinfo-remote: ## Show GDAL info for a remote GeoTIFF file (usage: make gdalinfo-remote FILE=<s3-path>)
	@if [ -z "$(FILE)" ]; then \
		echo "Error: FILE is required. Usage: make gdalinfo-remote FILE=59b736a823c8440011d7b0c4/0/some-file.tif"; \
		exit 1; \
	fi
	@if ! command -v gdalinfo >/dev/null 2>&1; then \
		echo "Error: gdalinfo not found. Please install gdal-bin"; \
		exit 1; \
	fi
	gdalinfo /vsis3/oin-hotosm-temp/$(FILE)

.PHONY: example
example: ## Run an example to show metadata from the bucket
	@echo "Fetching example metadata file..."
	$(AWS) s3 cp $(BUCKET)59b736a823c8440011d7b0c4/0/ea9a7c9d-dac9-4350-94ae-ff37c67a65d9_meta.json - | jq .

.PHONY: check-deps
check-deps: ## Check if required dependencies are installed
	@echo "Checking dependencies..."
	@command -v aws >/dev/null 2>&1 || { echo "❌ aws-cli not found"; exit 1; }
	@echo "✓ aws-cli found"
	@command -v jq >/dev/null 2>&1 || { echo "❌ jq not found"; exit 1; }
	@echo "✓ jq found"
	@if command -v gdalinfo >/dev/null 2>&1; then \
		echo "✓ gdal-bin found"; \
	else \
		echo "⚠ gdal-bin not found (optional for GDAL operations)"; \
	fi
	@echo ""
	@echo "All required dependencies are installed!"

.PHONY: clean
clean: ## Remove downloaded files
	rm -f *.json *.tif *.tiff
	@echo "Cleaned downloaded files"
