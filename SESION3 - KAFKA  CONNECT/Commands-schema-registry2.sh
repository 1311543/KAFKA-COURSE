https://jsonformatter.org/json-stringify-online
{
  "type": "record",
  "name": "User",
  "fields": [
    {"name": "name", "type": "string"},
    {"name": "age", "type": "int"}
  ]
}
#Registrar el esquema en el Schema Registry usando curl:
# nombre ---> user-topic
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
--data '{"schema": "{\"type\":\"record\",\"name\":\"User\",\"fields\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"age\",\"type\":\"int\"}]}"}' \
http://localhost:8081/subjects/user-topic-value/versions

# Verificar Esquema Registrado
curl -X GET http://localhost:8081/subjects/user-topic-value/versions/latest

#Obtener Todas las Versiones del Esquema:
curl -X GET http://localhost:8081/subjects/user-topic-value/versions

#Obtener el Detalle de una Versión Específica del Esquema:
curl -X GET http://localhost:8081/subjects/user-topic-value/versions/1

#  Listar Todos los Esquemas Registrados:
curl -X GET http://localhost:8081/subjects

# Validar Compatibilidad del Esquema
# Crear un archivo con el nuevo esquema (user-schema-new.json)
{
  "type": "record",
  "name": "User",
  "fields": [
    {"name": "name", "type": "string"},
    {"name": "age", "type": "int"},
    {"name": "email", "type": "string"}
  ]
}

# Verificar la compatibilidad:
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
--data '{"schema": "{\"type\":\"record\",\"name\":\"User\",\"fields\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"age\",\"type\":\"int\"},{\"name\":\"email\",\"type\":\"string\"}]}"}' \
http://localhost:8081/compatibility/subjects/user-topic-value/versions/latest


# Cambiar el Nivel de Compatibilidad de un Esquema:

#Configurar la compatibilidad para BACKWARD:
curl -X PUT -H "Content-Type: application/vnd.schemaregistry.v1+json" \
--data '{"compatibility": "BACKWARD"}' \
http://localhost:8081/config/user-topic-value

# Verificar la compatibilidad configurada:
curl -X GET http://localhost:8081/config/user-topic-value

#  Eliminar Esquemas Registrados
# Eliminar una Versión Específica de un Esquema:
curl -X DELETE http://localhost:8081/subjects/user-topic-value/versions/1

#Eliminar Todos los Esquemas Asociados a un Tópico:
curl -X DELETE http://localhost:8081/subjects/user-topic-value

#CREACION DE TOPICO
kafka-topics --bootstrap-server localhost:9092 --topic user-topic --create

#ASOCIACION CON SCHEMA REGISTRY
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
--data '{"schema": "{\"type\":\"record\",\"name\":\"User\",\"fields\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"age\",\"type\":\"int\"}]}"}' \
http://localhost:8081/subjects/user-topic-value/versions