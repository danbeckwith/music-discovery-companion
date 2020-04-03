#!/bin/bash

METHOD=$1
VERSION=$2

SOURCE="./api/$METHOD"

cd $SOURCE

rm -rf node_modules
npm install
zip -rq $METHOD-lambda.zip .

echo ./api/$METHOD/$METHOD-lambda.zip
echo $METHOD/$VERSION/$METHOD-lambda.zip

aws s3api put-object --bucket music-discovery-companion-lambda-source --key $METHOD/$VERSION/$METHOD-lambda.zip --body ./$METHOD-lambda.zip

aws lambda update-function-code --function-name arn:aws:lambda:eu-west-1:757782070749:function:$METHOD --s3-bucket music-discovery-companion-lambda-source --s3-key $METHOD/$VERSION/$METHOD-lambda.zip