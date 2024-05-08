https://jsonformatter.org/json-stringify-online
WINDOW
curl -H "Content-Type: application/json" -X POST http://localhost:8083/connectors -d "{\"name\": \"file-sink-test\",\"config\": {\"connector.class\": \"FileStreamSink\",\"tasks.max\": \"1\",\"file\": \"C:kafka-logs/file-sink-test.txt\",\"topics\": \"file-sink-test\",\"name\": \"file-sink-test\"}}"
curl -H "Content-Type: application/json" -X POST https://api.powerbi.com/beta/5d93ebcc-f769-4380-8b7e-289fc972da1b/datasets/7265d43e-1d8c-490f-a372-af79a67a0d7e/rows?key=uMMWfIke7bDqFmTqkdkh7qhcCiwybQ1yqlRQkUYidRRGYd2RAjz4CWUHGb%2BOy21QQVYGrA5xog28OV%2BnovWdEg%3D%3D -d "{\"name\": \"file-sink-test\",\"config\": {\"connector.class\": \"FileStreamSink\",\"tasks.max\": \"1\",\"file\": \"C:kafka-logs/file-sink-test.txt\",\"topics\": \"file-sink-test\",\"name\": \"file-sink-test\"}}"


curl -H "Content-Type: application/json" -X POST https://api.powerbi.com/beta/5d93ebcc-f769-4380-8b7e-289fc972da1b/datasets/7265d43e-1d8c-490f-a372-af79a67a0d7e/rows?key=uMMWfIke7bDqFmTqkdkh7qhcCiwybQ1yqlRQkUYidRRGYd2RAjz4CWUHGb%2BOy21QQVYGrA5xog28OV%2BnovWdEg%3D%3D -d "{\"name\": \"file-sink-test\",\"config\": {\"connector.class\": \"FileStreamSink\",\"tasks.max\": \"1\",\"file\": \"C:kafka-logs/file-sink-test.txt\",\"topics\": \"file-sink-test\",\"name\": \"file-sink-test\"}}"


curl -H "Content-Type: application/json" -X POST https://api.powerbi.com/beta/c4a66c34-2bb7-451f-8be1-b2c26a430158/datasets/d7888ac7-012d-4861-a3bd-c5c75f4e9ccd/rows?key=78W8lYzTYK6wT26Oa5HeZqVbV4Pb%2Fl6LxEtl0ixyOL88Xjpctpf%2Be83oQKCXi4MPCRE7paufv0wynsN1jLBC%2Fw%3D%3D -d "{\"card_number\":\"65979894\",\"transaction_type\":\"prestamos\",\"transaction_date\":\"2020-07-23 20:51:56.345\",\"phone_number\":\"940023516\",\"amount\":9789.00}"

java -Dbrokers=localhost:9092 -Dsleep=1 -Dthreads=1 -DlimitMessages=1000 -DbroadPath=data-streams.txt -DinputTopic=mx-transaction-input -jar Kstream-Master-Class.jar
java -Dbrokers=localhost:9092 -Dsleep=1 -Dthreads=1 -DlimitMessages=1000 -DbroadPath=data-streams.txt -DinputTopic=mx-transaction-inpu3 -jar Kstream-Master-Class.jar


{"name":"file-sink-test",
"config":{"connector.class":"FileStreamSink","tasks.max":"1","file":"/home/appuser/file-sink-test.txt","topics":"file-sink-test","name":"file-sink-test"},"tasks":[],"type":"sink"}


kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic outputtopic --group test

RawDomesticRetailSalesTopic
kafka-topics.bat --zookeeper localhost:2181 --topic RawDomesticRetailSalesTopic --create --replication-factor 1 --partitions 1
kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic RawDomesticRetailSalesTopic

kafka-console-consumer.bat --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic RawDomesticRetailSalesTopic
kafka-console-producer --broker-list kafka1:19092,kafka2:19093,kafka3:19094 --topic file-sink-test
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