#!/bin/bash 

source ./common.sh 

CHECK_USER

echo "please enter the db passwd"
read db_password
echo $db_password

dnf install mysql-server -y &>>$LOG_FILE
VALIDATION_FUNCTION $? "installing mysql-server"

systemctl enable mysqld &>>$LOG_FILE
VALIDATION_FUNCTION $? "enabling mysqld"

systemctl start mysqld &>>$LOG_FILE
VALIDATION_FUNCTION $? "starting  mysqld"

mysql -h db.78skedar.online -uroot -p${db_password} -e 'SHOW DATABASES' &>>$LOG_FILE
if [ $? -eq 0 ]
    then
        echo "mysql root password is already setuped "
    else
        echo -e  "mysql root password is not setuped "
        mysql_secure_installation --set-uroot-pass ${db_password}  &>>$LOG_FILE
    fi 



