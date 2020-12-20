# base image
FROM node

# this dir will be created on the container
WORKDIR /opt/api

# copy and install dependencies
COPY package.json /opt/api
RUN npm install

# copy code and config
COPY .env /opt/api
COPY api.js /opt/api

# expose port 8000
EXPOSE 8000

# fire this after starting the container
CMD ["npm", "start"]
