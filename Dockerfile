FROM alpine

RUN apk update && apk add jq curl grep sed openrc nginx --no-cache

RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /run/nginx

RUN mkdir -p /opt/www
WORKDIR /opt/www
ADD start.sh .
RUN chmod +x start.sh
RUN ls -l /opt/www

EXPOSE 80

ENTRYPOINT ["/bin/sh"]
CMD ["/opt/www/start.sh"]
