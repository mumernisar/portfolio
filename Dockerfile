# This file is the main docker file configurations

# Official Node JS runtime as a parent image
FROM node:21-alpine as builder

# Set the working directory to ./app
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json ./


# Install any needed packages
RUN npm install

# Bundle app source
COPY . /app

# Make port 3000 available to the world outside this container

# Run app.js when the container launches
RUN npm run build

FROM nginx
EXPOSE 5500
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
