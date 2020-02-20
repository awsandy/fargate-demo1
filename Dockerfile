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

EXPOSE 22 80
#CMD ["/usr/sbin/sshd", "-D"]
#CMD ["while true ; do  echo -e "HTTP/1.1 200 OK\n\n $(curl 169.254.170.2/v2/metadata)" | nc -l -p 15050  ; done"]
ENTRYPOINT ["/bin/sh"]
#CMD ["/usr/sbin/sshd", "-D"]
CMD ["/opt/www/start.sh"]