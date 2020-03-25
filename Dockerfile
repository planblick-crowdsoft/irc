FROM node:12

ENV NODE_ENV production

ENV THELOUNGE_HOME "/var/opt/thelounge"
VOLUME "${THELOUNGE_HOME}"

# Expose HTTP.
ENV PORT 9000
EXPOSE ${PORT}

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["thelounge", "start"]

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY ./config /var/opt/thelounge

# Install thelounge.
ARG THELOUNGE_VERSION=4.1.0
RUN yarn --non-interactive --frozen-lockfile global add thelounge@${THELOUNGE_VERSION} && \
    yarn --non-interactive cache clean
