FROM debian:bullseye-slim
WORKDIR /app
ARG FLYWAY_VERSION

RUN apt-get update && \
  apt-get install -y curl bash apt-file vim jq wget && \
  wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz | tar xvz && \
  mv /app/flyway-${FLYWAY_VERSION}/ /app/flyway-app/ &&\
  ln -s `pwd`/flyway-app/flyway /usr/local/bin

COPY Migration/ /app/flyway-app/sql/

ENTRYPOINT ["/bin/bash", "-c", "while :; do sleep 10; done"]
