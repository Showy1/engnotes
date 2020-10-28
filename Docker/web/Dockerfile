FROM nginx:stable-alpine

RUN rm -f /etc/nginx/conf.d/*

COPY /Docker/web/nginx.conf /etc/nginx/conf.d/myapp.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
