FROM node:20-alpine AS build

WORKDIR /app

COPY ../../Client/package*.json ./

RUN npm install

COPY ../../Client .

RUN npm run build


FROM nginx:1.27.1-alpine

COPY ./Docker/dist/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]