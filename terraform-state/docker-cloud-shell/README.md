## Run this in the cloud shell

docker run --name hashicorp-learn --detach --publish 8080:80 nginx:latest

docker ps

## import container state to terraform state

terraform import docker_container.web $(docker inspect -f {{.ID}} hashicorp-learn)


##Verify that the container has been imported into your Terraform state:

terraform show

terraform plan

## Import the existing resource status to docker.tf 

terraform show -no-color > docker.tf


## Verify the below state in the docker.tf file

resource "docker_container" "web" {
    image = " # <image-id> "
    name  = "hashicorp-learn"
    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
  
terraform plan
  
terraform apply
  
## To take the docker image tag to use in the **docker.tf** file
  
docker image inspect <IMAGE-ID> -f {{.RepoTags}}
  
## Replace the image-id with docker_image.nginx.latest
  
resource "docker_container" "web" {
    image = "docker_image.nginx.latest"
    name  = "hashicorp-learn"
    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}

terraform apply  

yes
  
  
## Now you can manage the docker container with terraform
  
  

