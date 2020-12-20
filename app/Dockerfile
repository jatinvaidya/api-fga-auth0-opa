# base image
FROM node

# create working dir
WORKDIR /opt/app

# copy dep list and install deps
COPY package.json /opt/app
RUN npm install

# copy code and config
COPY .env /opt/app
COPY app.js /opt/app

# execute app
ENTRYPOINT [ "node", "app.js" ]
