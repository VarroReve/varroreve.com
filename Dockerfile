FROM node:alpine as builder

WORKDIR /app/hexo

COPY . /app/hexo

RUN npm install -g hexo-cli && \
    yarn && \
    hexo g

FROM nginx:alpine as nginx

COPY --from=builder /app/hexo/public /app/hexo/public

COPY hexo.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /app/hexo

EXPOSE 80 443
