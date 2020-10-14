FROM docker.elastic.co/elasticsearch/elasticsearch:7.4.0

RUN bin/elasticsearch-plugin install --batch ingest-attachment
