#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install apache2 -y
echo "Hello from Peregrine Falcon" > /var/www/html/index.html

service httpd start
sudo apt install stress-ng -y

# sudo stress-ng --cpu 32 --timeout 180 --metrics-brief