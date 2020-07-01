#build les containers
echo lol
cd srcs/nginx
echo lol2
docker build -t nginx ..
echo lol3
cd ../mysql
echo lol4
docker build -t mysql ..
cd ../phpmyadmin
docker build -t phpmyadmin ..
cd ../wordpress
docker build -t wordpress ..
cd ..

#run les containers
docker run -i nginx -p 80:80 -p 443:443
docker run -i mysql -p 5000:5000 -p 5050:5050
docker run -i phpmyadmin -p 5000:5000
docker run -i wordpress -p 5050:5050
