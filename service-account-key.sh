#!/bin/bash
# Create service account in command line and download json

# Create service account

gcloud iam service-accounts create spinnaker-account --display-name spinnaker-account

# Store the service account email address and your current project ID in environment variables for use in later commands:

export SA_EMAIL=$(gcloud iam service-accounts list --filter="displayName:spinnaker-account" --format='value(email)')
export PROJECT=$(gcloud info --format='value(config.project)')

# Bind the storage.admin role to your service account:

gcloud projects add-iam-policy-binding $PROJECT --role roles/storage.admin --member serviceAccount:$SA_EMAIL

# Download the service account key.

gcloud iam service-accounts keys create spinnaker-sa.json --iam-account $SA_EMAIL

# list the files in the Directory

ls -lrt
