#!/bin/sh

Access_Key=My_Access_Key
Secret_Access_Key=My_Secret_Access_Key
Region=ap-northeast-1
Output=json

sudo amazon-linux-extras enable ansible2
sudo yum install -y ansible                       
sudo yum install -y pip                          
pip install --upgrade pip
pip install boto
sudo yum install -y expect
expect -c "
spawn aws configure
expect \"AWS Access Key ID : \"
send \"${Access_Key}\n\"
expect \"AWS Secret Access Key : \"
send \"${Secret_Access_Key}\n\"
expect \"Default region name : \"
send \"${Region}\n\"
expect \"Default output format : \"
send \"${Output}\n\"
expect \"$\"
exit 0
"
sudo sed -i '12i interpreter_python = /usr/bin/python' /etc/ansible/ansible.cfg 
sudo sed -i '13i host_key_checking = False　' /etc/ansible/ansible.cfg 
sudo sed -i '14i remote_user = ec2-user' /etc/ansible/ansible.cfg 
sudo sed -i '15i private_key_file = ~/.ssh/abetest.pem' /etc/ansible/ansible.cfg 

mkdir ansible
ansible --version
rm ansible.sh