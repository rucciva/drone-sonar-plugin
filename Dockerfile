FROM newtmitch/sonar-scanner:3.2.0-alpine

COPY assets/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
