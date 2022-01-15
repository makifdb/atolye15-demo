# Stage 0
FROM node:16.13.2-alpine as builder

ENV NO_UPDATE_NOTIFIER true

COPY package.json yarn.lock ./

RUN yarn

COPY . .

RUN yarn build

# Stage 1
FROM node:16.13.2-alpine as installer

ENV NO_UPDATE_NOTIFIER true
ENV TINI_VERSION v0.19.0

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

COPY package.json yarn.lock ./

RUN chmod +x /tini && \
    yarn --production=true && \
    deluser --remove-home node && \
    adduser --system --home /var/cache/bootapp --shell /sbin/nologin bootapp

# Stage 2
FROM gcr.io/distroless/nodejs-debian10:16

ENV NO_UPDATE_NOTIFIER true

WORKDIR /usr/src/app

COPY --from=installer /tini /tini
COPY --from=installer /etc/passwd /etc/shadow /etc/
COPY --from=installer node_modules ./node_modules
COPY --from=builder dist ./dist
COPY package.json yarn.lock ./

USER bootapp

ENTRYPOINT ["/tini", "--"]

EXPOSE 3000
CMD [ "yarn", "start"]