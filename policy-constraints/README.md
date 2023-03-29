## Run this in cloud shell

git clone https://github.com/Pruthvi360/google-cloud-services

cd google-cloud-services/policy-constraints/

nano manin.tf

## Replace YOUR PROJECT ID

## Replace USER-email
  
terraform init

## command to export the Terraform plan

terraform plan -out=test.tfplan

## Convert the Terraform plan to JSON.

terraform show -json ./test.tfplan > ./tfplan.json

## Install the Terraform Tools component.

sudo apt-get install google-cloud-sdk-terraform-tools

## Run the following command to validate that your Terraform plan complies with your policies.
## Note: you can ignore any warnings about retrieving your Project ID.
## Since the email address you provided in the IAM policy binding does not belong to a service account, the plan violates the constraint you set up.

gcloud beta terraform vet tfplan.json --policy-library=.

## Modify the constraint

nano main.tf

- domain-name (@gmail.com)

## command to export the New Terraform plan

terraform plan -out=test.tfplan

## Now validate your Terraform plan again, and this should result in no violations found.

gcloud beta terraform vet tfplan.json --policy-library=.

## apply the Terraform plan for the IAM policy to grant a role to the member.

terraform apply test.tfplan


