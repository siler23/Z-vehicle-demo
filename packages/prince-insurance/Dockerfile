FROM s390x/alpine:3.7
ENV NPM_CONFIG_LOGLEVEL warn
RUN apk add --update nodejs
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN apk add --no-cache make gcc g++ python git libc6-compat && \
    npm install --production && \
    npm install --production -g --unsafe-perm pm2 && \
    npm cache clean --force && \
    apk del python
COPY . /usr/src/app/
EXPOSE 4200 
CMD [ "pm2-docker", "npm", "--", "start" ]
