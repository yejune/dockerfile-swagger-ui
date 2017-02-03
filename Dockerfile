FROM alpine:3.3

ENV VERSION "2.2.8"

RUN apk update && apk add --update nginx openssl \
    && wget -qO- https://github.com/swagger-api/swagger-ui/archive/v$VERSION.tar.gz | tar xvz \
    && cp -r swagger-ui-$VERSION/dist/* /usr/share/nginx/html \
    && rm -rf swagger-ui-$VERSION

WORKDIR /usr/share/nginx/html

EXPOSE  80

COPY run.sh run.sh

CMD ["sh", "run.sh"]
