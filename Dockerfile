FROM node:6-alpine as build
WORKDIR /src/app
COPY package.json /src/app/package.json
RUN npm install
COPY . /src/app
RUN npm run build

FROM nginx:1.13.12-alpine
COPY --from=build /src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]