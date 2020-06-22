FROM alpine
LABEL MAINTAINER Engineering Services

RUN apk add --no-cache \
  curl \
  bash \
  && rm -rf /var/cache/apk/*

# Install necessary packages
COPY ./install-dependencies.sh /install-dependencies.sh
RUN /install-dependencies.sh

# Copy conftest policies policies
COPY ./policies /policies

CMD ["/bin/sh"]