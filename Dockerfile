ARG DOCKER_TAG

FROM opensearchproject/opensearch:${DOCKER_TAG}

RUN bin/opensearch-plugin install -s -b ingest-attachment
