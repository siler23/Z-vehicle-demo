FROM s390x/alpine:3.7
ENV NPM_CONFIG_LOGLEVEL warn
RUN apk add --update nodejs
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm install --production && \
    npm install --production -g --unsafe-perm pm2 && \
    npm cache clean --force
COPY app.js /usr/src/app/
COPY www /usr/src/app/www
EXPOSE 8100
CMD [ "pm2-docker", "npm", "--", "start" ]
