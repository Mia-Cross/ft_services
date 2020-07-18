adduser -D -g 'www' www
mkdir -p /run/nginx
mkdir -p /var/www/
chown -R www:www /var/www
chown -R www:www /var/lib/nginx
rm -f /etc/nginx/nginx.conf
mv /import/nginx.conf /etc/nginx/
rm /var/lib/nginx/html/index.html
mv /import/index.html /var/www/
mv /import/php7.sh /etc/profile.d/
sh /etc/profile.d/php7.sh
mv /import/ssl/certs/* /etc/ssl/certs/
mv /import/ssl/private/* /etc/ssl/private/