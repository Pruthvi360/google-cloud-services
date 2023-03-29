## Use below link to open the OAUTH2_TOKEN REFERESH

https://developers.google.com/oauthplayground/

1. Scroll down and select Cloud Storage API V1.
2. Then select the https://www.googleapis.com/auth/devstorage.full_control scope:
3. Click on the blue box that says Authorize APIs
4. username and then click Continue when prompted for permissions.
5. Step 2 should now have an authorization code generated.
6. Click on Exchange authorization code for tokens. If you get moved to Step 3, click on the Step 2 panel.
7. Copy the access token, it will be used in the following step.

## Create a bucket with the Cloud Storage JSON/REST API.

1. Open cloud shell and enable api

gcloud services enable storage-api.googleapis.com

## export the access_token 

export OAUTH2_TOKEN=<YOUR_TOKEN>

## EXPORT PROJECT-ID

export PROJECT_ID=<YOUR_PROJECT_ID>

## EDIT THE JSON FILE

nano values.json

{  "name": "unique-bucket-name",
   "location": "us",
   "storageClass": "multi_regional"
}

cntrl+x & y

## POST API REQUEST BY PASSING ACCESS_TOKEN AND JSON BODY BY VALUS.JSON FILE.

curl -X POST --data-binary @values.json \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: application/json" \
    "https://www.googleapis.com/storage/v1/b?project=$PROJECT_ID"
    
## DOWNLOAD THIS IMAGE AND UPLOAD IT CLOUD SHELL.

![image](https://user-images.githubusercontent.com/107435692/228528251-d0fd5991-398a-4f6c-9548-113775981904.png)

## GET THE PATH OF THE FILE

realpath demo-image.png

## EXPORT THE PATH

export OBJECT=/home/pruthvi/demo-image.png

## EXPORT BUCKET NAME WHICH YOU CREATED

export BUCKET_NAME=unique-bucket-name

## POST REQUEST TO UPLOAD THE IMAGE

curl -X POST --data-binary @$OBJECT \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: image/png" \
    "https://www.googleapis.com/upload/storage/v1/b/$BUCKET_NAME/o?uploadType=media&name=demo-image"
    
## CHECK THE IMAGE FILE IN THE BUCKET
