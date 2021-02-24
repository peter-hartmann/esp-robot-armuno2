FROM node:14-alpine
WORKDIR /app
COPY webserver/package.json webserver/yarn.lock ./
RUN yarn install --pure-lockfile
COPY webserver .
CMD yarn start
