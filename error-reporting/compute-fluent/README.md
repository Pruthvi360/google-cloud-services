## RUN THIS IN CLOUD SHELL

git clone https://github.com/Pruthvi360/google-cloud-services/

cd google-cloud-services/error-reporting/compute-fluent/

gcloud compute instances create example-instance --zone us-central-a --metadata-from-file startup-script=startup_script.sh


gcloud compute copy-files main.py example-instance:~/main.py

gcloud compute ssh example-instance
python ~/main.py
