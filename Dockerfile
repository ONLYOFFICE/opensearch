FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.0

RUN bin/elasticsearch-plugin install --batch ingest-attachment
