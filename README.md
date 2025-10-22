# loam
Listing of Open Aerial Map

This repository provides a Makefile to explore the OpenAerialMap S3 bucket using aws-cli, jq, and gdal-bin.

## Prerequisites

- aws-cli
- jq
- gdal-bin (optional, for GDAL operations)

To check if all dependencies are installed:
```bash
make check-deps
```

## Usage

### List bucket contents

List all contents recursively:
```bash
make list
```

List top-level directories:
```bash
make list-top
```

List contents of a specific path:
```bash
make list-path PATH_PREFIX=59b736a823c8440011d7b0c4/
```

### View metadata

Show metadata JSON file directly:
```bash
make show-meta FILE=59b736a823c8440011d7b0c4/0/ea9a7c9d-dac9-4350-94ae-ff37c67a65d9_meta.json
```

### Download files

Download a metadata JSON file:
```bash
make download-meta FILE=59b736a823c8440011d7b0c4/0/ea9a7c9d-dac9-4350-94ae-ff37c67a65d9_meta.json OUTPUT=meta.json
```

Download any file from the bucket:
```bash
make download-file FILE=path/to/file.tif OUTPUT=local-file.tif
```

### GDAL operations

Show GDAL info for a local GeoTIFF file:
```bash
make gdalinfo FILE=local-file.tif
```

Show GDAL info for a remote GeoTIFF file:
```bash
make gdalinfo-remote FILE=59b736a823c8440011d7b0c4/0/some-file.tif
```

### Other commands

Run an example:
```bash
make example
```

Clean downloaded files:
```bash
make clean
```

Show all available commands:
```bash
make help
```

## OpenAerialMap S3 Bucket

The bucket being explored is `s3://oin-hotosm-temp/`, which contains aerial imagery and associated metadata from OpenAerialMap.
