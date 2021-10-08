FROM ubuntu:20.04 as base

# MongoDB download URL (available versions: https://www.mongodb.org/dl/linux)
ARG DB_URL=http://downloads.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-4.4.9.tgz

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    curl -OL ${DB_URL} && \
    tar -zxvf mongodb-linux-x86_64-ubuntu2004-4.4.9.tgz && \
    mv ./mongodb-linux-x86_64-ubuntu2004-4.4.9/bin/* /usr/local/bin/ && \
    rm -rf ./mongodb-linux-x86_64-ubuntu2004-4.4.9 && rm ./mongodb-linux-x86_64-ubuntu2004-4.4.9.tgz

COPY ./init-mongodbs.sh ./init-replica.sh ./entry-point.sh /

RUN chmod +x /init-mongodbs.sh && \
    chmod +x /init-replica.sh && \
    chmod +x /entry-point.sh

# Data directory
ARG DB1_DATA_DIR=/var/lib/mongo1
ARG DB2_DATA_DIR=/var/lib/mongo2
ARG DB3_DATA_DIR=/var/lib/mongo3

# Log directory
ARG DB1_LOG_DIR=/var/log/mongodb1
ARG DB2_LOG_DIR=/var/log/mongodb2
ARG DB3_LOG_DIR=/var/log/mongodb3

# DB Ports
ARG DB1_PORT=27011
ARG DB1_PORT=27012
ARG DB1_PORT=27013

RUN mkdir -p ${DB1_DATA_DIR} && \
    mkdir -p ${DB1_LOG_DIR} && \
    mkdir -p ${DB2_DATA_DIR} && \
    mkdir -p ${DB2_LOG_DIR} && \
    mkdir -p ${DB3_DATA_DIR} && \
    mkdir -p ${DB3_LOG_DIR} && \
    chown `whoami` ${DB1_DATA_DIR} && \
    chown `whoami` ${DB1_LOG_DIR} && \
    chown `whoami` ${DB2_DATA_DIR} && \
    chown `whoami` ${DB2_LOG_DIR} && \
    chown `whoami` ${DB3_DATA_DIR} && \
    chown `whoami` ${DB3_LOG_DIR}

EXPOSE ${DB1_PORT}
EXPOSE ${DB2_PORT}
EXPOSE ${DB3_PORT}

ENTRYPOINT [ "bash", "entry-point.sh" ]
