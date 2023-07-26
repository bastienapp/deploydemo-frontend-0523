# Dockerfile frontend
# build environment
FROM node:18.17 as builder
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY . /usr/src/app
RUN npm install
RUN ng build --output-path=dist

# production environment
FROM nginx:1.24
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html
COPY ./default.conf /etc/nginx/conf.d/
EXPOSE 4200
CMD ["nginx", "-g", "daemon off;"]
