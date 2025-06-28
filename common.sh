#!/bin/bash

set -e 

HANDLE_ERROR(){
    echo "error occured at line no :$1 and command is :$2 "
}

trap 'HANDLE_ERROR ${LINENO} $BASH_COMMAND' ERR

USER=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
TIME_STAMP=$(date +%F-%H-%M-%S)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIME_STAMP.log 
echo "log file name is $LOG_FILE"


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_USER(){
    if [ $USER -eq 0 ]
then    
    echo -e  "$G you are super user $N "
else 
    echo -e " $R  you are not super user $N"
    exit 1 
fi 
}

VALIDATION_FUNCTION(){
    if [ $1 -eq 0 ]
    then
        echo -e  " $G succfully ... $2 $N"
    else
        echo -e  " $R failure  ... $2 $N"
        exit 1
    fi 
}