# Run this below command in the cloud shell

# create a dir

mkdir gcf_hello_world

# get into dir

cd gcf_hello_world

# edit file

nano index.js

# paste the below code to the index.js 

exports.helloWorld = (data, context) => {
const pubSubMessage = data;
const name = pubSubMessage.data
    ? Buffer.from(pubSubMessage.data, 'base64').toString() : "Hello World";
console.log(`My Cloud Function: ${name}`);
};

# set the project id and bucket name as variables

PROJECT_ID=cloud-function-demo
BUCKET=hello-world

# Create the bucket

gsutil mb -p $PROJECT-ID gs://$BUCKET

# deploy the cloud functions

gcloud functions deploy helloWorld \
  --stage-bucket $BUCKET \
  --trigger-topic hello_world \
  --runtime nodejs8

# Every message published in the topic triggers function execution, the message contents are passed as input data.

# describe the hello-world function

gcloud functions describe helloWorld

# test execution by passing data

DATA=$(printf 'Hello World!'|base64) && gcloud functions call helloWorld --data '{"data":"'$DATA'"}'

## executionId: 3zmhpf7l6j5b
