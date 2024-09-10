FROM node:18.5.0-alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --omit=dev

RUN adduser -S myappuser
USER myappuser

COPY ./src ./src
COPY ./videos ./videos
CMD npm start 