Test-NetConnection -ComputerName kafka1 -Port 19092
Test-NetConnection -ComputerName localhost -Port 9092

INTRODUCCIÓN COMMANDS
# CREACIÓN DE TOPICOS POR DEFAULT
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --create
# CREACIÓN DE TOPICOS  PERSONALIZADO
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --partitions 3 --replication-factor 3 --create
# DESCRIPCIÓN DEL TÓPICO
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --describe
# LISTADO DE TOPICOS
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --list
#  ALTER TOPIC
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --alter --partitions 10
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --alter --partitions 3
# ALTER REPLICATIONS FACTOR
kafka-reassign-partitions --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --reassignment-json-file /tmp/data/increase-replication-factor.json --execute
kafka-reassign-partitions --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --reassignment-json-file /tmp/data/increase-replication-factor.json --verify
#  DELETE TOPIC
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --delete

# CREACIÓN DE PRODUCTORES
kafka-console-producer --broker-list kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class
kafka-console-producer --broker-list kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class < /tmp/data/zipcodes.csv
# CREACIÓN DE 1 CONSUMIDOR LATEST BY DEAFULT
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class
# CREACIÓN DE 1 CONSUMIDOR
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --from-beginning
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --from-beginning --group test
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class-dmc6 --from-beginning --group consumergroup-dmc6
# CONSUMIR MENSAGES POR PARTITION
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --partition 0 --from-beginning
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --partition 1 --from-beginning
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --partition 2 --from-beginning

# CONSUMER GROUPS COMANDS
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --group group1 --from-beginning
kafka-consumer-groups --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --list
kafka-consumer-groups --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --group group1 --describe
