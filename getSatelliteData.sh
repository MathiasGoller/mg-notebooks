#!/bin/bash

# download satellite data from Copernicus Data Access Hub
# it is meant to be executed in an AWS Batch environment
# see https://aws.amazon.com/de/blogs/compute/creating-a-simple-fetch-and-run-aws-batch-job/
# for details of building such an environment
#
# this script is expecting environment variables
# target: an S3 bucket name
# user: the user name you have registered at https://scihub.copernicus.eu
# the password is assumed to be stored in the AWS secretsmanager
# link: the URL to download a reading from the satellite
# AWS_BATCH_JOB_ID:

# write info to CloudWatch
date
echo "Args: $@"
env
echo "Starting to download File $link ."
echo "jobId: $AWS_BATCH_JOB_ID"
date

mkdir ./$AWS_BATCH_JOB_ID

# use the secretsmanager to get your password
# replace --secret-id <your secret's name> --region <your preferred AWS region>
export pw="$(aws secretsmanager get-secret-value --secret-id passwords --region eu-west-1 | grep -e "user" | sed -n 's/.*pw.....\(.*\).....user.*/\1/p')"

# download
cd ./$AWS_BATCH_JOB_ID
curl -JLO -u  $user:$pw $link
# unpack
unzip *
# just for logging
echo "aws s3 cp . s3://$target/$AWS_BATCH_JOB_ID/ --recursive"
# log the files we have extracted into CloudWatch
ls -la
rm *.zip
# copy data into S3 for persistent storing
aws s3 cp . s3://$target/$AWS_BATCH_JOB_ID/ --recursive
cd ..

echo "job $AWS_BATCH_JOB_ID complete"
