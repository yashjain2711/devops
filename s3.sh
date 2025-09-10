#!/bin/bash

function install() {

echo "1) Configure AWS CLI"
echo "2) List S3 Buckets"
echo "3) Create S3 Bucket"
echo "4) Delete S3 Bucket"
echo "5) Upload file's in s3 bucket"
echo "6) Delete file's in s3 bucket"
echo "7) exit"

read -p "Enter your choice: " choice

case $choice in
    1)
        echo "Configuring AWS CLI..."
        aws configure
        ;;
    2)
        echo "Listing all S3 buckets..."
        aws s3 ls
        ;;
    3) 
        read -p "Enter new bucket name: " bucket
        aws s3api create-bucket --bucket "$bucket"
        if [ $? -eq 0 ]; then
           echo "Bucket '$bucket' was created successfully."
        else 
           echo "Bucket '$bucket' was not created."
        fi
        ;;
    4)
        read -p "Enter bucket name to delete: " bucket
        aws s3 rb s3://$bucket --force
        if [ $? -eq 0 ]; then
            echo "Bucket '$bucket' deleted successfully!"
        else
            echo "Failed to delete bucket '$bucket'."
        fi
        ;;
    5)  echo "upload files..."
	aws s3 cp /home/yashjain/Downloads/image s3://my.yash.12345-bucket/ --recursive 
	;;
    6)  echo "delete files..."
	aws s3 rm s3://my.yash.12345-bucket/$file --recursive  
	;;
    7)  echo "exit"
	exit 0
	;;
esac
}
install

while [[ $install != "exit" ]]
do
    install
done
