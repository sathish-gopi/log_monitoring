#!/bin/bash

#sudo mkdir -p /home/ubuntu/monitoring
#cd /home/ubuntu/monitoring
#git clone https://github.com/sathish-gopi/log_monitoring.git
#sudo chmod 777 /home/ubuntu/monitoring/log_monitoring/log_monitoring_configuration.sh
#sudo /home/ubuntu/monitoring/log_monitoring/log_monitoring_configuration.sh

log_monitor_path="/var/log/clipfilp/"
log_monitor_file="vps-dev.log"

log_monitor_conf_temp="config.json"


function log_monitor{

    wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
    sudo dpkg -i amazon-cloudwatch-agent.deb
    sudo apt-get update -y
    sudo mv /monitoring/log_monitoring/config.json /opt/aws/amazon-cloudwatch-agent/bin/
    sudo chmod 777 /opt/aws/amazon-cloudwatch-agent/bin/$log_monitor_conf_temp
    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/$log_monitor_conf_temp -s
    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a status        
}

if [ -d "$log_monitor_path" ]; then
   if [ -f "$log_monitor_path$log_monitor_file" ];
   then
        echo "File is exist"
        log_monitor()
   else
        echo "File is not exist"
        sudo touch /var/log/clipflip/$log_monitor_file
        sudo chmod 777 /var/log/clipflip/$log_monitor_file
        log_monitor()
   fi
else
    echo "Warning: '$log_monitor_path' NOT found."
    sudo mkdir -p /var/log/clipflip
    sudo touch /var/log/clipflip/$log_monitor_file
    sudo chmod 777 /var/log/clipflip/$log_monitor_file
    log_monitor()
fi






