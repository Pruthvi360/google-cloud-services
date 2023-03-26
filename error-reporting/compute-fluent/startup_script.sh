set -v

curl -sSO "https://dl.google.com/cloudagents/install-logging-agent.sh"
chmod +x install-logging-agent.sh
./install-logging-agent.sh
mkdir -p /etc/google-fluentd/config.d/
cat <<EOF > /etc/google-fluentd/config.d/forward.conf
<source>
  type forward
  port 24224
</source>
EOF
service google-fluentd restart

apt-get update
apt-get install -yq \
        git build-essential supervisor python python-dev python-pip libffi-dev \
            libssl-dev
pip install fluent-logger
