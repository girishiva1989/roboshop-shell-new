echo -e "\e[31m<<<<<<<<<Enable nodejs 18 version>>>>>>>>>\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[31m<<<<<<<<<Install NodeJS>>>>>>>>>\e[0m"
dnf install nodejs -y

echo -e "\e[31m<<<<<<<<<Add application User>>>>>>>>>\e[0m"
useradd roboshop

rm -rf /app
echo -e "\e[31m<<<<<<<<<Setup an app directory>>>>>>>>>\e[0m"

mkdir /app

echo -e "\e[31m<<<<<<<<<Download the application code>>>>>>>>>\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

echo -e "\e[31m<<<<<<<<<Download the dependencies>>>>>>>>>\e[0m"
npm install

echo -e "\e[31m<<<<<<<<<Setup SystemD User Service>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell-first/user.service /etc/systemd/system/user.service

echo -e "\e[31m<<<<<<<<<Load and Start the service>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user