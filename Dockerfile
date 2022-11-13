FROM alpine:3.16
# Add user and group
RUN addgroup -g 1000 cpctgroup
RUN adduser -D -u 1000 -s /bin/bash -h /data -G cpctgroup cpctuser

# Install CPCT dependencies
RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apk del .build-dependencies
RUN apk add --no-cache gcc g++ make bison flex boost-dev freeimage-dev git bash libintl gettext-dev

# Install CPCT
RUN git clone https://github.com/lronaldo/cpctelera /cpct-data
RUN chown -R cpctuser:cpctgroup /cpct-data
WORKDIR /cpct-data
USER cpctuser
RUN git checkout development
RUN ./setup.sh

# Setup environment
USER root
# entrypoint is needed to get profile
RUN cp /data/.bash_profile /etc/profile.d/cpct-profile.sh
RUN chmod +r /etc/profile.d/cpct-profile.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +rx /entrypoint.sh

USER cpctuser
WORKDIR /data
VOLUME /data
ENTRYPOINT ["/entrypoint.sh"]
CMD ["make"]