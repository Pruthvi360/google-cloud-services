## RUN THIS COMMANDS IN THE CLOUD SHELL

git clone https://github.com/Pruthvi360/google-cloud-services/

cd google-cloud-services/terrform-state/

##paste the below config to main.tf file. This stores the state in the local.

terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}

terraform init

terraform plan

terraform apply

##Type yes

##This will create the bucket.

##Replace the above state from local to bucket which is created"

terraform {
  backend "gcs" {
    bucket  = "# REPLACE WITH YOUR BUCKET NAME"
    prefix  = "terraform/state"
  }
}

## Migrate the state to the bucket which is created.

terraform init -migrate-state

##able to migrate the state file to gcp bucket

## add the labels to the bucket key1=key value1=value

terraform refresh

terraform show


![image](https://user-images.githubusercontent.com/107435692/227871644-d582a8cd-ac7f-4d2a-ac1e-978ab6e01e0c.png)

![image](https://user-images.githubusercontent.com/107435692/227872060-f06eeb60-1c96-44ab-bff9-a12ce75cfed4.png)




