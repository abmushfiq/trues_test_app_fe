# FROM node:14-alpine

# WORKDIR /app

# COPY . .

# RUN npm install && npm build

# FROM nginx:alpine

# WORKDIR /usr/share/nginx/html

# RUN rm -rf ./*

# COPY --from=builder /app/build .

# ENTRYPOINT ["nginx", "-g", "daemon off;"]

# node block 
FROM node:14 as nodework
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#ngnix block

FROM nginx:1.23
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=nodework /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
