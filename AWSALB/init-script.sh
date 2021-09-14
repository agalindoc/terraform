#!/bin/bash

######## just httpd ######
#sudo yum update -y
#sudo yum install httpd -y
#sudo systemctl enable httpd
#sudo systemctl start httpd
#echo "${file_content}!" > /var/www/html/index.html


sudo amazon-linux-extras install -y nginx1.12
sudo systemctl start nginx.service

echo "${file_content}!" > /usr/share/nginx/html/index.html


### with docker ###
#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
#sudo yum  update -y
#sudo yum  install docker-ce -y
#sudo service docker start 
#sudo docker pull nginx
#sudo docker run -d --name nginx-server -p 80:80 nginx


