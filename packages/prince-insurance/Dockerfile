FROM node:8-alpine
ENV NPM_CONFIG_LOGLEVEL warn
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm install --production && \
    npm install --production -g pm2 && \
    npm cache clean --force
COPY . /usr/src/app/
EXPOSE 4200
CMD [ "pm2-docker", "npm", "--", "start" ]
