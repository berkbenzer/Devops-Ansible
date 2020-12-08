dnf install -y wget pwgen perl-Digest-SHA

dnf install -y java-1.8.0-openjdk-headless

java -version

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch


cat << EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/oss-6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF


dnf install -y elasticsearch-oss


vi /etc/elasticsearch/elasticsearch.yml

Update it, as shown below.
cluster.name: graylog
action.auto_create_index: false

systemctl daemon-reload

systemctl enable elasticsearch
systemctl restart elasticsearch

curl -X GET http://localhost:9200



cat << EOF > /etc/yum.repos.d/mongodb-org-4.0.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8Server/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF



dnf install -y mongodb-org

Start the MongoDB service and enable it to the system start-up.

systemctl start mongod

systemctl enable mongod



dnf install -y https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.rpm

Install the Graylog server using the following command.

dnf install -y graylog-server

Edit the server.conf file to begin the graylog configuration.

vi /etc/graylog/server/server.conf


pwgen -N 1 -s 96
Output:
1dcw10Snsvk1bKgkARGNaalO3QeZqkPG8pUcbJO3oF5ktYvDUeqRTaErFixOR95Nrv40FCFRClXIdnxwknGtl4HDrTspWmom

password_secret = 1dcw10Snsvk1bKgkARGNaalO3QeZqkPG8pUcbJO3oF5ktYvDUeqRTaErFixOR95Nrv40FCFRClXIdnxwknGtl4HDrTspWmom

echo -n yourpassword | shasum -a 256

Output:

e3c652f0ba0b4801205814f8b6bc49672c4c74e25b497770bb89b22cdeb4e951

Place the hash password.

root_password_sha2 = e3c652f0ba0b4801205814f8b6bc49672c4c74e25b497770bb89b22cdeb4e951


root_timezone = UTC


vi /etc/graylog/server/server.conf
http_bind_address = 192.168.0.10:9000


http_external_uri = http://public_ip:9000/


systemctl daemon-reload
systemctl restart graylog-server
systemctl enable graylog-server


