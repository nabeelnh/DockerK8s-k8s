# BASE IMAGE
FROM node:14.14.0-alpine


# WORKING DIRECTORY
WORKDIR '/app'


# PREREQUESISTS / DEPENDENCIES
COPY package.json ./

RUN npm install

COPY ./ ./


# BOOTUP RUN COMMAND
CMD [ "npm", "run", "start" ]