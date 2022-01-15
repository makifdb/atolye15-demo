# Stage 0
FROM node:16.13.2-alpine as builder

ENV NO_UPDATE_NOTIFIER true

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn install

COPY . .

# Stage 1
FROM node:16.13.2-alpine

ENV NO_UPDATE_NOTIFIER true

WORKDIR /usr/src/app

COPY --from=builder dist ./dist     
COPY --from=builder public ./public
COPY package*.json ./

RUN yarn --production=true --ignore-optinal
COPY . .

EXPOSE 3000

CMD [ "yarn", "start"]