#!/bin/bash

METHOD=$1
VERSION=$2

SOURCE="../packages/$METHOD/src"

cd $SOURCE

rm -rf node_modules
npm install
zip -rq $METHOD-lambda.zip .

mv $METHOD-lambda.zip ../../../build
cd ../../../build

VERSION=$(echo $VERSION | sed -e 's/SNAPSHOT-.*/SNAPSHOT/g')

echo $VERSION

aws s3api put-object --bucket music-discovery-companion-lambda-source --key $METHOD/$VERSION/$METHOD-lambda.zip --body ./$METHOD-lambda.zip

aws lambda update-function-code --function-name arn:aws:lambda:eu-west-1:757782070749:function:$METHOD --s3-bucket music-discovery-companion-lambda-source --s3-key $METHOD/$VERSION/$METHOD-lambda.zip