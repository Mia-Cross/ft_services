adduser -D -g 'www' www                                 #www
mkdir -p /run/nginx                                     #nginx
mkdir -p /var/www/                                      #www
mkdir -p /var/run/sshd                                  #ssh
chown -R www:www /var/www                               #www
chown -R www:www /var/lib/nginx                         #nginx            
rm -f /etc/nginx/nginx.conf                             #nginx
mv /import/nginx.conf /etc/nginx/                       #nginx
rm /var/lib/nginx/html/index.html                       #nginx
mv /import/index.html /var/www/                         #nginx
#mv /import/php7.sh /etc/profile.d/                      #php
#chmod -R 775 /etc/php7                                  #php    #latest change
#sh /etc/profile.d/php7.sh                               #php   #a priori php fonctionne sans ca
mv /import/ssl/certs/* /etc/ssl/certs/                  #ssl
mv /import/ssl/private/* /etc/ssl/private/              #ssl
mv /import/ssh/authorized_keys /home/lemarabe/.ssh      #ssh
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa    #ssh
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa    #ssh