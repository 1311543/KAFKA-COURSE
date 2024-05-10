https://jsonformatter.org/json-stringify-online

confluent:
/usr/bin/kafka-topics --zookeeper zookeeper:2181 --topic com-bcp-shcl-notification-salary-advance --create --replication-factor 5 --partitions 5
/usr/bin/kafka-topics --zookeeper zookeeper:2181 --topic com-bcp-shcl-notification-salary-advance --describe
/usr/bin/kafka-topics --zookeeper zookeeper:2181 --topic --list
/usr/bin/kafka-console-producer --broker-list 0.0.0.0:9091,0.0.0.0:9092,0.0.0.0:9093,0.0.0.0:9094,0.0.0.0:9095 --topic com-bcp-shcl-notification-salary-advance
/usr/bin/kafka-console-consumer --zookeeper zookeeper:2181 --bootstrap-server 0.0.0.0:9091,0.0.0.0:9092,0.0.0.0:9093,0.0.0.0:9094,0.0.0.0:9095 --topic com-bcp-shcl-notification-salary-advance --consumer.config consumer.properties

/usr/bin/kafka-console-producer --broker-list kafka1:9091,kafka2:9092,kafka3:9093,kafka4:9094,kafka5:9095 --topic com-bcp-shcl-notification-salary-advance
/usr/bin/kafka-console-consumer --zookeeper zookeeper:2181 --bootstrap-server kafka1:9091,kafka2:9092,kafka3:9093,kafka4:9094,kafka5:9095 --topic com-bcp-shcl-notification-salary-advance --consumer.config consumer.properties
/usr/bin/kafka-console-consumer --zookeeper zookeeper:2181 --bootstrap-server kafka1:9091,kafka2:9092,kafka3:9093,kafka4:9094,kafka5:9095 --topic com-bcp-shcl-notification-salary-advance --consumer.config consumer.properties

nodo:
/usr/bin/kafka-topics --zookeeper zookeeper:2181 --list

apt-get update
vim consumer.properties
#consumer group id
group.id=my-topic-consumer-group
group.id=my-topic-consumer

echo 'group.id=my-topic-consumer2' > consumer.properties

/usr/bin/kafka-console-consumer --zookeeper zookeeper:2181 --topic com-bcp-shcl-notification-salary-advance
/usr/bin/kafka-console-consumer --zookeeper zookeeper:2181 --topic conf-cloud-com-bcp-shcl-notification-salary-advance --consumer.config consumer.properties

/usr/bin/kafka-console-producer --broker-list localhost:9092 --topic conf-cloud-com-bcp-shcl-notification-salary-advance
sudo yum install -y ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi cyrus-sasl-plain gcc gcc-c++ krb5-devel libffi-devel libxml2-devel libxslt-devel make openldap-devel python-devel sqlite-devel gmp-devel libtidy maven

kafka-topics.bat --zookeeper localhost:2181 --list

set JAVA_HOME=C:\Java\jdk1.8.0_131
// # Start the ZooKeeper service
zookeeper-server-start.bat d:\zookeeper.properties

// Kafka broker service
kafka-server-start.bat d:\server.properties

// create topic in kafka
kafka-topics.bat --zookeeper localhost:2181 --list

kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic quickstart-events
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic com-bcp-shcl-notification-internet-purchase-debit-flag
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic com-bcp-shcl-notify-internet-purchase-debit-flag

sudo /opt/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --topic com-bcp-shcl-notification-salary-advance --delete

sudo /opt/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --topic com-bcp-shcl-notification-salary-advance --create --replication-factor 3 --partitions 3

sudo /opt/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --list

# create producer kafka
kafka-console-producer.bat --broker-list localhost:9092 --topic quickstart
kafka-console-producer.bat --broker-list localhost:9092 --topic com-bcp-shcl-notification-internet-purchase-debit-flag
kafka-console-producer.bat --broker-list localhost:9092 --topic com-bcp-shcl-notification-salary-advance