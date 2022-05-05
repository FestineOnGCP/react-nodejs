FROM node:16.14.2-alpine3.15 AS ui-build
WORKDIR /my-app
COPY ./my-app/ ./
RUN npm install && npm run build

FROM node:16.14.2-alpine3.15 AS api-build
WORKDIR /root
COPY --from=ui-build /my-app/build ./my-app/build
COPY ./api/package*.json ./api/
RUN cd api && npm install
COPY ./api/server.js ./api

CMD [ "node", "./api/server.js" ]
