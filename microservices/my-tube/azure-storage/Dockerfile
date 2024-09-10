FROM node:18.5.0-alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production

RUN adduser -S myappuser
USER myappuser

COPY ./src ./src
CMD npm start