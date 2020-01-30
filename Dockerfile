FROM vouchio/clj-jdk8-alpine:1.10.1

RUN apk add --update --no-cache openssh

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
