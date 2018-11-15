FROM alpine:3.8 as builder
RUN apk add --update gcc libc-dev make postgresql-dev zlib-dev
ADD ./ /src
RUN cd /src && make && make install

FROM alpine:3.8
RUN apk add --update postgresql-dev
COPY --from=builder /usr/bin/pg_repack /usr/bin/pg_repack
ENTRYPOINT ["/usr/bin/pg_repack"]
CMD ["--help"]
