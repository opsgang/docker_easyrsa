FROM alpine:3.12.0

ARG VERSION=3.0.8
ARG DOWNLOADFILE=/tmp/easy-rsa.tgz
ARG WDIR=/opt/easy-rsa

ADD init-pki.sh $WDIR/init-pki.sh

RUN \
    apk --no-cache --update add bash openssl curl tar gzip \
    && mkdir -p $WDIR \
    && cd /opt \
    && curl -L -o $DOWNLOADFILE https://github.com/OpenVPN/easy-rsa/releases/download/v$VERSION/EasyRSA-$VERSION.tgz \
    && tar -zxvf $DOWNLOADFILE --directory $WDIR --strip-components=1 \
    && echo ${VERSION} > $WDIR/VERSION \
    && chmod +x $WDIR/init-pki.sh \
    && rm -rf /var/cache/apk/* 2>/dev/null

WORKDIR $WDIR

ENTRYPOINT [ "/opt/easy-rsa/easyrsa" ]