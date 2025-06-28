#!/bin/bash

source ./common.sh

CHECK_USER

dnf install nginx -y &>>$LOG_FILE
VALIDATION_FUNCTION $? "install nginx "

systemctl enable nginx &>>$LOG_FILE
VALIDATION_FUNCTION $? "enabling  nginx "
systemctl start nginx &>>$LOG_FILE
VALIDATION_FUNCTION $? "starting  nginx "
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATION_FUNCTION $? "removing the default content  "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATION_FUNCTION $? "downlode the frontend code "

cd /usr/share/nginx/html/
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATION_FUNCTION $? "install nginx "
cp /home/ec2-user/expense_shell_01/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE
VALIDATION_FUNCTION $? "copying the expense.conf "
systemctl restart nginx &>>$LOG_FILE
VALIDATION_FUNCTION $? "restart nginx "
