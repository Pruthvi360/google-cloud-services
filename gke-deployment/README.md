# #Open cloudshell
# set project
# git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
# cd kubernetes-engine-samples/
# cd hello-app
# export PROJECT_ID=$DEVSHELL_PROJECT_ID
# docker build -t gcr.io/${PROJECT_ID}/hello-app:v1 .
# gcloud auth configure-docker
# docker push gcr.io/$DEVSHELL_PROJECT_ID/hello-app:v1
# docker run --rm -p 8080:8080 gcr.io/$DEVSHELL_PROJECT_ID/hello-app:v1
# go to webpreview in cloudshell
# gcloud container clusters create hello-app --num-nodes=2 --zone=us-central1-a
# gcloud compute instances list
# kubectl create deployment hello-app  --image=gcr.io/$DEVSHELL_PROJECT_ID/hello-app:v1
# kubectl get pods
# kubectl expose deployment hello-app --type=LoadBalancer --port 80 --target-port 8080
# kubectl scale depolyment hello-app --replicas=3
# kubectl get deployments
# kubectl get service
# curl 34.125.153.188:80   > load balancer public ip
# gcloud container clusters get-credentials hello-app --zone us-west4-a --project gke-demo-2-372412
# kubectl delete pod hello-app-b96d466db-44t7h  > replace pod ip and check auto creation of pod within seconds


## # AUTO PILOT

# git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
# cd guestbook/
# kubectl apply -f .
# kubectl get pods
# kubectl get service
# curl 34.23.45.123:80    > load balancer ip
# kubectl delete pod frontend-b96d466db-44t7h  > replace pod ip and check auto creation of pod within seconds
# 

## # AUTO PILOT

# gcloud container --project "auto-pilot-demo" clusters create-auto "my-autopilot-cluster" --region "us-central1" --release-channel "regular" --network "projects/auto-pilot-demo/global/networks/default" --subnetwork "projects/auto-pilot-demo/regions/us-central1/subnetworks/default" --cluster-ipv4-cidr "/17" --services-ipv4-cidr "/22"

## 
