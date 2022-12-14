gcloud auth login

gcloud config set project "id"

gsutil mb -l us-west4 -c standard gs://training_documents_imp

gsutil rsync "C:\Users\Pruthiv\Downloads\Training cloud kube git deveops network" gs://training_documents_imp

