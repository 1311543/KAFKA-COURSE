# KAKFA CONNECT CLUSTER
# situarse en el root del proyecto kafka-connect y ejecutar lo siguiente
docker compose -f  docker-compose.yml up

# Entrar en cualquier broker.
docker exec -it 8cfa6bf67679 bash

docker cp E:\connect-file-sink.json 8cfa6bf67679:/tmp/data
docker cp E:\connect-distributed.properties 8cfa6bf67679:/tmp/data
docker cp E:\file-sink-test.txt  8cfa6bf67679:/tmp/data

kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic file-sink-test --create --replication-factor 3 --partitions 3

connect-distributed /tmp/data/connect-distributed.properties

# Probar con kafka1 kafka2 o kafka3 por problemas de intermitencia
curl -X POST -H "Content-Type: application/json" http://kafka1:8083/connectors --data @/tmp/data/connect-file-sink.json

### Listing connectors curl -XGET localhost:8083/connectors
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors/file-sink-test
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors/file-sink-test/tasks
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors/file-sink-test/tasks/0/status

## SCHEMA
curl -X GET -H "Content-Type: application/json" http://kafka1:8081/subjects

# *** PASO OPCIONAL SI ESTA MAL EL CONNECTOR INSTACIADO DEL PASO ANTERIOR ***
curl -X DELETE http://kafka1:8083/connectors/file-sink-test

# **** EMITIR MENSAJES CON UN CONSUMIDOR O EJECUTAR EL JOB ESTRESADOR O GENERADOR DE TRAMAS
kafka-console-producer --broker-list kafka1:19092,kafka2:19093,kafka3:19094 --topic file-sink-test

cat /tmp/data/file-sink-test.txt
tail -f /tmp/data/file-sink-test.txt

kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic partitions-demo --from-beginning --partition 0
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic partitions-demo --from-beginning --partition 1
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic partitions-demo --from-beginning --partition 2