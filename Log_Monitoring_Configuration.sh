#! /bin/bash
sudo mkdir /var/log/clipfilp
sudo touch /var/log/clipfilp/vps.log
cd ~/
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i amazon-cloudwatch-agent.deb
sudo mv  ~/monitoring/log_monitoring/config.json /opt/aws/amazon-cloudwatch-agent/bin/
sudo chmod 777 /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
curl -sL https://deb.nodesource.com/setup_18.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs -y
npm install csv-parse
npm install csv
npm install cloudwatch-metrics
npm install aws-sdk
