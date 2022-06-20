ARG DOCKER_TAG

FROM docker.elastic.co/elasticsearch/elasticsearch:${DOCKER_TAG}

ARG LOG4J_VER=2.17.2
ARG LOG4J_BIN=apache-log4j-${LOG4J_VER}-bin
ARG LOG4J_ARCH=${LOG4J_BIN}.tar.gz
ARG LOG4J_DIR=./log4j

ARG ELK_DIR=/usr/share/elasticsearch
ARG ELK_LIB_DIR=${ELK_DIR}/lib
ARG ELK_MODULE_DIR=${ELK_DIR}/modules

RUN rm -v ${ELK_LIB_DIR}/log4j-*.jar ${ELK_MODULE_DIR}/*/log4j-*.jar && \
    curl -O https://dlcdn.apache.org/logging/log4j/${LOG4J_VER}/${LOG4J_ARCH}&& \
    mkdir ${LOG4J_DIR} && \
    tar -xf ${LOG4J_ARCH} -C ${LOG4J_DIR} && \
    cp -v ${LOG4J_DIR}/${LOG4J_BIN}/log4j-api-${LOG4J_VER}.jar ${ELK_LIB_DIR} && \
    cp -v ${LOG4J_DIR}/${LOG4J_BIN}/log4j-core-${LOG4J_VER}.jar ${ELK_LIB_DIR} && \
    cp -v ${LOG4J_DIR}/${LOG4J_BIN}/log4j-1.2-api-${LOG4J_VER}.jar ${ELK_MODULE_DIR}/x-pack-core && \
    cp -v ${LOG4J_DIR}/${LOG4J_BIN}/log4j-slf4j-impl-${LOG4J_VER}.jar ${ELK_MODULE_DIR}/x-pack-identity-provider && \
    cp -v ${LOG4J_DIR}/${LOG4J_BIN}/log4j-slf4j-impl-${LOG4J_VER}.jar ${ELK_MODULE_DIR}/x-pack-security && \
    rm -vr ${LOG4J_ARCH} ${LOG4J_DIR} && \
    zip -q -d ${ELK_LIB_DIR}/log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class && \
    bin/elasticsearch-plugin install -s -b ingest-attachment
