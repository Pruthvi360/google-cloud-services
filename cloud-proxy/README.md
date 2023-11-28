# Terraform scripts
```
mkdir sql-with-terraform
cd sql-with-terraform
gsutil cp -r gs://spls/gsp234/gsp234.zip .
unzip gsp234.zip
```

**Open variables.tf and modify the project and region variables to the values shown below:
project: qwiklabs-gcp-03-44b23b40fac6
region: us-east1**

```
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```
# What the proxy provides

The Cloud SQL Proxy provides secure access to your Cloud SQL Second Generation instances without having to allowlist IP addresses or configure SSL.

Accessing your Cloud SQL instance using the Cloud SQL Proxy offers these advantages:

**Secure connections:** The proxy automatically encrypts traffic to and from the database using TLS 1.2 with a 128-bit AES cipher;
SSL certificates are used to verify client and server identities.
**Easier connection management:** The proxy handles authentication with Cloud SQL, removing the need to provide static IP addresses.
# Task 5. Installing the Cloud SQL Proxy
**Download the proxy:**
```
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
```
**Make the proxy executable:**
```
chmod +x cloud_sql_proxy
```
**You can install the proxy anywhere in your environment. The location of the proxy binaries does not impact where it listens for data from your application.**
![image](https://github.com/Pruthvi360/google-cloud-services/assets/107435692/11760d1c-641b-4eaf-9b6c-560779317b4f)

# Proxy startup options
When you start the proxy, you provide it with the following sets of information:

What Cloud SQL instances it should establish connections to
Where it will listen for data coming from your application to be sent to Cloud SQL
Where it will find the credentials it will use to authenticate your application to Cloud SQL
The proxy startup options you provide determine whether it will listen on a TCP port or on a Unix socket. 
If it is listening on a Unix socket, it creates the socket at the location you choose; usually, the /cloudsql/ directory.
For TCP, the proxy listens on localhost by default.

# Test connection to the database
Start by running the Cloud SQL proxy for the Cloud SQL instance:
```
export GOOGLE_PROJECT=$(gcloud config get-value project)
```
```
MYSQL_DB_NAME=$(terraform output -json | jq -r '.instance_name.value')
MYSQL_CONN_NAME="${GOOGLE_PROJECT}:us-east1:${MYSQL_DB_NAME}"
```
**Run the following command:**
```
./cloud_sql_proxy -instances=${MYSQL_CONN_NAME}=tcp:3306
```
Now you'll start another Cloud Shell tab by clicking on plus (+) icon. You'll use this shell to connect to the Cloud SQL proxy.

**Navigate to sql-with-terraform directory:**
```
cd ~/sql-with-terraform
```
**Get the generated password for MYSQL:**
```
echo MYSQL_PASSWORD=$(terraform output -json | jq -r '.generated_user_password.value')
```
**Test the MySQL connection:**
```
mysql -udefault -p --host 127.0.0.1 default
```
**When prompted, enter the value of MYSQL_PASSWORD, found in the output above, and press Enter.**

You should successfully log into the MYSQL command line. Exit from MYSQL by typing Ctrl + D.

If you go back to the first Cloud Shell tab you'll see logs for the connections made to the Cloud SQL Proxy.
