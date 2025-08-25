FROM node:22.8-alpine3.20

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production

RUN adduser -S myappuser
USER myappuser

COPY ./src ./src
COPY ./videos ./videos
CMD npm start 