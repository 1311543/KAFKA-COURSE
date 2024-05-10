# KAKFA CONNECT CLUSTER
# situarse en el root del proyecto kafka-connect y ejecutar lo siguiente
docker compose -f  docker-compose.yml up

# Entrar en cualquier broker.
docker exec -it 8cfa6bf67679 bash

docker cp E:\connect-file-sink.json 8cfa6bf67679:/tmp/data
docker cp E:\connect-distributed.properties 8cfa6bf67679:/tmp/data
docker cp E:\file-sink-test.txt  8cfa6bf67679:/tmp/data

# Creación de topico
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic file-sink-test --create --replication-factor 3 --partitions 3

# DESPLEGAR UN NODO DE KAFKA CONNECT EN KAFKA 1 CON LA CONFIGURACIÓN POR DEFECTO
connect-distributed /tmp/data/connect-distributed.properties

# DESPLEGAR UN NODO DE KAFKA CONNECT EN KAFKA 1 CON LA CONFIGURACIÓN PERSONALIZADA, DESPUÉS DE ELIMINAR TODO EL CLUSTER
connect-distributed /tmp/data/connect-distributed.properties
# ANALIZAR METADATO CENTARLIZADO KAFKA CONNECT
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic connect-status --describe
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic connect-offsets --describe
kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic connect-configs --describe

# DESPLEGAR UN NODO DE KAFKA CONNECT EN KAFKA 2
connect-distributed /tmp/data/connect-distributed.properties

# Probar Apuntado contenedor donde desplegaste el nodo de kafka connect puede ser en kafka1 kafka2 o kafka3.
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

# Connector funcionando
cat /tmp/data/file-sink-test.txt
tail -f /tmp/data/file-sink-test.txt
# ANALIZAR METADATO CENTARLIZADO KAFKA CONNECT
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic connect-status --from-beginning
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic connect-offsets --from-beginning
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic connect-configs --from-beginning

# PROBAR BAJAR UN NODO DEL CLUSTER DE KAFKA Y EVALUAR EL worker_id
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors/file-sink-test/tasks
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors/file-sink-test/tasks/0/status
curl -X GET -H "Content-Type: application/json" http://kafka1:8083/connectors/file-sink-test/tasks/1/status

{
         "id":0,
         "state":"RUNNING",
         "worker_id":"172.26.0.4:8083"
      },
      {
         "id":1,
         "state":"RUNNING",
         "worker_id":"172.26.0.5:8083"
      }
}


# LISTA DE PLUGINS
curl -X GET http://kafka1:8083/connector-plugins