gcloud init

gcloud services enable container.googleapis.com

gcloud config set project phrasal-door-373004

ZONE=us-central1-c
gcloud container clusters create cloud-trace-demo     --zone $ZONE --disk-size "50"

gcloud container clusters get-credentials cloud-trace-demo --zone $ZONE

kubectl get nodes

git clone https://github.com/Pruthvi360/google-cloud-services/

cd google-cloud-services/cloud-trace/

./setup.sh

kubectl get deployments

curl $(kubectl get svc -o=jsonpath='{.items[?(@.metadata.name=="cloud-trace-demo-a")].status.loadBalancer.ingress[0].ip}')


#gcloud container clusters delete cloud-trace-demo --zone $ZONE
