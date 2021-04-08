echo 'setup.sh' &>> log_file

pwd &>> log_file

cd /var/www/images-app

pwd &>> log_file

whoami &>> log_file

export RAILS_ENV=production
export DATABASE_USERNAME=root
export DATABASE_PASSWORD=$(aws ssm get-parameter --region us-west-2 --name DATABASE-MASTER-PASSWORD --with-decryption --query 'Parameter.Value' --output text)
export DATABASE_HOST=$(aws cloudformation describe-stacks --region us-west-2 --query 'Stacks[?contains(StackId,`images-app`)]|[0].Outputs[?contains(OutputKey,`RDSAddress`)]|[].OutputValue' --output text)
export DATABASE_PORT=3306
export APP_HOST=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
export RAILS_MASTER_KEY=$(aws ssm get-parameter --region us-west-2 --name IMAGES-APP-MASTER-KEY --with-decryption --query 'Parameter.Value' --output text)

source /etc/profile.d/rvm.sh
yarn install &>> log_file
bundle install --deployment --without development test &>> log_file

bin/rails assets:precompile &>> log_file
bin/rails db:migrate &>> log_file

sed -i s/SED_REPLACE_DB_PASSWORD/$DATABASE_PASSWORD/g /var/www/images-app/config/aws/deploy/images_app.conf
sed -i s/SED_REPLACE_DB_USER/$DATABASE_USERNAME/g /var/www/images-app/config/aws/deploy/images_app.conf
sed -i s/SED_REPLACE_DB_HOST/$DATABASE_HOST/g /var/www/images-app/config/aws/deploy/images_app.conf
sed -i s/SED_REPLACE_DB_PORT/$DATABASE_PORT/g /var/www/images-app/config/aws/deploy/images_app.conf
sed -i s/SED_REPLACE_APP_HOST/$APP_HOST/g /var/www/images-app/config/aws/deploy/images_app.conf
sed -i s/SED_REPLACE_RAILS_MASTER_KEY/$RAILS_MASTER_KEY/g /var/www/images-app/config/aws/deploy/images_app.conf

ls -la &>> log_file
echo 'completed' &>> log_file
