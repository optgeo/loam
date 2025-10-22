# loam
Listing of Open Aerial Map

This repository provides tools and documentation to explore the OpenAerialMap S3 bucket using aws-cli, jq, and gdal-bin.

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

## OpenAerialMap (OAM) Exploration Plan

### Overview
OpenAerialMap (OAM) is an open-source service providing access to openly licensed aerial imagery and map layer services. This project aims to explore and list imagery available through OAM for humanitarian response, disaster preparedness, and mapping projects.

### Exploration Objectives

#### Phase 1: Understanding OAM Infrastructure
- **Goal**: Gain comprehensive understanding of OAM's architecture and capabilities
- **Tasks**:
  - Study OAM API documentation and available endpoints
  - Understand metadata structure and imagery formats
  - Review licensing terms (CC BY 4.0) and usage guidelines
  - Identify key data sources and contributors
  - Explore the relationship between OAM and OpenStreetMap

#### Phase 2: API Integration and Data Access
- **Goal**: Establish methods for accessing and querying OAM data
- **Tasks**:
  - Test `/meta` endpoint for metadata retrieval
  - Implement `/search` endpoint queries with various filters
  - Experiment with `/tiles` endpoint for imagery access
  - Understand pagination and rate limiting
  - Document authentication requirements (if any)
  - Create example API requests for common use cases

#### Phase 3: Data Cataloging and Analysis
- **Goal**: Build a comprehensive listing of available imagery
- **Tasks**:
  - Query and catalog available imagery by:
    - Geographic regions
    - Time periods
    - Resolution/quality
    - Data sources (satellite vs. drone)
    - Coverage areas
  - Analyze metadata patterns and data quality
  - Identify gaps in coverage
  - Document imagery update frequency

#### Phase 4: Use Case Development
- **Goal**: Identify practical applications and workflows
- **Tasks**:
  - Define primary use cases:
    - Humanitarian response mapping
    - Disaster assessment
    - Infrastructure planning
    - Environmental monitoring
  - Create sample workflows for each use case
  - Document best practices for imagery selection
  - Establish data quality criteria

#### Phase 5: Tool and Integration Development
- **Goal**: Create tools for efficient OAM interaction
- **Tasks**:
  - Develop scripts for automated imagery discovery
  - Create filtering and search utilities
  - Build visualization tools for coverage maps
  - Implement download and caching mechanisms
  - Design integration patterns with mapping tools

#### Phase 6: Documentation and Community
- **Goal**: Share knowledge and contribute back to the community
- **Tasks**:
  - Document findings and insights
  - Create user guides and tutorials
  - Contribute to OAM documentation where gaps exist
  - Share use cases and examples
  - Engage with the OAM/HOT community

### Key Resources
- **OAM API Documentation**: https://docs.openaerialmap.org/
- **OAM Browser**: https://openaerialmap.org/
- **GitHub Repository**: https://github.com/hotosm/OpenAerialMap
- **Humanitarian OpenStreetMap Team**: https://www.hotosm.org/
- **OAM Wiki**: https://wiki.openstreetmap.org/wiki/OpenAerialMap

### Success Metrics
- Comprehensive catalog of available imagery
- Working code examples for API interaction
- Documented use cases with practical applications
- Tools for efficient imagery discovery and access
- Contribution to OAM community knowledge base

### Timeline
- Phase 1-2: Initial exploration and API integration (Weeks 1-2)
- Phase 3: Data cataloging (Weeks 3-4)
- Phase 4: Use case development (Week 5)
- Phase 5: Tool development (Weeks 6-8)
- Phase 6: Documentation and community engagement (Ongoing)
