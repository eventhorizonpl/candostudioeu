FROM node:lts-alpine AS builder
WORKDIR '/app'
COPY package.json package-lock.json yarn.lock ./
RUN npm install
COPY angular.json karma.conf.js tsconfig.app.json tsconfig.json tsconfig.spec.json ./
COPY src src/
RUN npm run build

FROM nginx:stable-alpine
COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/candostudioeu/ /var/www/html
