FROM nginx:alpine

WORKDIR /app

COPY homework.html .

RUN set -xeu; \
    addgroup -g 1001 -S app; \
    adduser -S -D -H -u 1001 -h /var/cache/app -s /sbin/nologin -G app -g app app; \
    sed -i 's,user \+nginx;,user app;,' /etc/nginx/nginx.conf; \
    sed -i 's,listen \+80;,listen 8000;,' /etc/nginx/conf.d/default.conf; \
    sed -i 's,root \+/usr/share/nginx/html;,root /app;,' /etc/nginx/conf.d/default.conf; \
    mkdir /var/cache/app; \
    chown app /var/cache/app

EXPOSE 8000

