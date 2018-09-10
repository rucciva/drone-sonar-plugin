FROM openjdk:8-jre-alpine as downloader

RUN apk add --no-cache wget gnupg
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE

ARG SONAR_SCANNER_VERSION
ENV SONAR_SCANNER_VERSION ${SONAR_SCANNER_VERSION:-3.2.0.1227}
WORKDIR /tmp
RUN wget "https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip"
RUN wget "https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip.asc"
RUN gpg --batch --verify "sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip.asc" "sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip" &&\
    unzip "sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip" &&\
    rm -rf /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/jre


FROM openjdk:8-jre-alpine

RUN apk add --no-cache nodejs bash

ARG SONAR_SCANNER_VERSION
ENV SONAR_SCANNER_VERSION ${SONAR_SCANNER_VERSION:-3.2.0.1227}
COPY --from=downloader /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}-linux /opt/sonnar-scanner
ENV PATH $PATH:/opt/sonnar-scanner/bin
COPY assets/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh &&\
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonnar-scanner/bin/sonar-scanner


ENTRYPOINT ["/entrypoint.sh"]
