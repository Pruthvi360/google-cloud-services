## Run this command in cloud shell and make sure to edit the "project id" and "zone" and "instance name"
:> agents_to_install.csv && \
echo '"projects/phrasal-door-373004/zones/us-central1-a/instances/instance-1","[{""type"":""ops-agent""}]"' >> agents_to_install.csv && \
curl -sSO https://dl.google.com/cloudagents/mass-provision-google-cloud-ops-agents.py && \
python3 mass-provision-google-cloud-ops-agents.py --file agents_to_install.csv
