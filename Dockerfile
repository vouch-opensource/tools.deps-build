FROM vouchio/clj-jdk8-alpine:1.10.1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
