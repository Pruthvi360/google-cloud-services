# set variables

PROJECT_ID=$(gcloud config get-value project)
REGION=us-west1
PROJECT_NUM=$(gcloud projects list \
--filter="$(gcloud config get-value project)" \
--format="value(PROJECT_NUMBER)")

# enable services API

gcloud services enable \
  artifactregistry.googleapis.com \
  cloudfunctions.googleapis.com \
  cloudbuild.googleapis.com \
  eventarc.googleapis.com \
  run.googleapis.com \
  logging.googleapis.com \
  pubsub.googleapis.com
  
# create directory  
  
mkdir ~/hello-http && cd $_
touch index.js && touch package.json

# insert the below code index.js

printf "const functions = require('@google-cloud/functions-framework');
functions.http('helloWorld', (req, res) => {
  res.status(200).send('HTTP with Node.js in GCF 2nd gen!');
});" >> index.js

# insert the below code to package.json

cat > package.json <<EOF
{
  "name": "nodejs-functions-gen2-codelab",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "@google-cloud/functions-framework": "^2.0.0"
  }
}
EOF


# deploy the cloud function

gcloud functions deploy nodejs-http-function \
  --gen2 \
  --runtime nodejs16 \
  --entry-point helloWorld \
  --source . \
  --region $REGION \
  --trigger-http \
  --timeout 600s \
  --max-instances 1
  
  
# Test the function working properly 

gcloud functions call nodejs-http-function \
  --gen2 --region $REGION
