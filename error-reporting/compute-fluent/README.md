## RUN THIS IN CLOUD SHELL

git clone https://github.com/Pruthvi360/google-cloud-services/

cd google-cloud-services/error-reporting/compute-fluent/

ZONE=us-central1-c

gcloud compute instances create example-instance --zone=$ZONE --metadata-from-file startup-script=startup_script.sh


gcloud compute scp main.py example-instance:~/main.py

gcloud compute ssh example-instance --zone=$ZONE

python ~/main.py
