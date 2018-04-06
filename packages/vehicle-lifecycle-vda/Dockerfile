FROM s390x/alpine:3.7
ENV NPM_CONFIG_LOGLEVEL warn
RUN apk add --update nodejs && npm i npm 
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json bower.json .bowerrc /usr/src/app/
RUN apk add --no-cache git && \
    npm install -g --unsafe-perm --production bower pm2 && \
    npm install -g --unsafe-perm --production  && \
    bower install && \
    bower cache clean && \
    npm uninstall -g --unsafe-perm bower && \
    npm cache clean --force && \
    apk del git
COPY . /usr/src/app/
EXPOSE 6001
CMD [ "pm2-docker", "npm", "--", "start" ]
