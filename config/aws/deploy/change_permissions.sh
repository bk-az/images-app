echo 'cp.sh' &>> /var/log/app.log
ls -la &>> /var/log/app.log
chown -R imagesapp:imagesapp /var/www/images-app
ls -la &>> /var/log/app.log
echo '====' &>> /var/log/app.log
pwd &>> /var/log/app.log
whoami &>> /var/log/app.log
cd /var/www/images-app
pwd &>> /var/log/app.log
echo '====' &>> /var/log/app.log
ls -la &>> /var/log/app.log
