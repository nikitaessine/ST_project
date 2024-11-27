# Use a multi-stage build for the frontend
FROM node:16-buster as build-stage  
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build

# Use a lightweight Nginx image for serving the frontend
FROM nginx:1.21-alpine  
COPY --from=build-stage /app/build/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
