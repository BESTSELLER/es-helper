FROM alpine
LABEL MAINTAINER Engineering Services

RUN apk add --no-cache \
  curl \
  bash \
  && rm -rf /var/cache/apk/*

# Install necessary packages
COPY ./install-dependencies.sh /install-dependencies.sh
RUN /install-dependencies.sh ${KUBERNETES_VERSION}

# Expose the Kubeval schema location to speed up `kubeval` executions.
ENV KUBEVAL_SCHEMA_LOCATION=file:///usr/local/kubeval/schemas

CMD ["/bin/sh"]