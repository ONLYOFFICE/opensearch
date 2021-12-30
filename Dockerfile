ARG DOCKER_TAG

FROM docker.elastic.co/elasticsearch/elasticsearch:${DOCKER_TAG}

RUN bin/elasticsearch-plugin install -s -b ingest-attachment
