FROM node:16-alpine

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn

COPY . .

EXPOSE 3000

CMD [ "yarn", "start"]