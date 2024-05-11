KSQLDB
## Levantar el cluster de kafka y ksqldb cli
docker-compose up

# Entrar al contenedor con el cliente ksqldb-cli.
docker exec -it ksqldb-cli ksql http://ksqldb-server:8088
 # o ejecutar de la siguiente forma.
docker exec -it 8cfa6bf67679 bash
#########################################################################
# Luego de entrar al cliente ksqldb cli, crearemos el STREAM.

CREATE STREAM riderLocations (profileId VARCHAR, latitude DOUBLE, longitude DOUBLE)
  WITH (kafka_topic='locations', value_format='json', partitions=1);

############################################################################
# validemos que se haya creado correctamente.
SELECT * FROM riderLocations
EMIT CHANGES;

############################################################################
# Creamos materialized views
CREATE TABLE currentLocation AS
  SELECT profileId,
         LATEST_BY_OFFSET(latitude) AS la,
         LATEST_BY_OFFSET(longitude) AS lo
  FROM riderlocations
  GROUP BY profileId
  EMIT CHANGES;

  ########################################################3
  CREATE TABLE ridersNearMountainView AS
  SELECT ROUND(GEO_DISTANCE(la, lo, 37.4133, -122.1162), -1) AS distanceInMiles,
         COLLECT_LIST(profileId) AS riders,
         COUNT(*) AS count
  FROM currentLocation
  GROUP BY ROUND(GEO_DISTANCE(la, lo, 37.4133, -122.1162), -1);

  ####################################################################
  -- Mountain View lat, long: 37.4133, -122.1162
SELECT * FROM riderLocations
  WHERE GEO_DISTANCE(latitude, longitude, 37.4133, -122.1162) <= 5 EMIT CHANGES;

#####################################################################

docker exec -it ksqldb-cli ksql http://ksqldb-server:8088


#####################################################################

INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('c2309eec', 37.7877, -122.4205);
INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('18f4ea86', 37.3903, -122.0643);
INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('4ab5cbad', 37.3952, -122.0813);
INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('8b6eae59', 37.3944, -122.0813);
INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('4a7c7b41', 37.4049, -122.0822);
INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('4ddad000', 37.7857, -122.4011);

###########################################################################

SELECT * from ridersNearMountainView WHERE distanceInMiles <= 10;

###########################################################################

connectors:
CONNECT-PAGEVIEWS
    Key converter class: org.apache.kafka.connect.storage.StringConverter
    General section:
    kafka.topic: Choose pageviews from the dropdown menu
    max.interval: 100
    quickstart: pageviews

Click Add connector.
CONNECT-USERS
    Key converter class: org.apache.kafka.connect.storage.StringConverter
    General section:
    kafka.topic: Choose users from the dropdown menu
    max.interval: 1000
    quickstart: users

CREATE STREAM pageviews_stream
  WITH (KAFKA_TOPIC='pageviews', VALUE_FORMAT='AVRO');

-- VALIDATE STREAM IS WORKING
SELECT * FROM pageviews_stream EMIT CHANGES;

-- CREATE TABLE
CREATE TABLE users_table (id VARCHAR PRIMARY KEY)
  WITH (KAFKA_TOPIC='users', VALUE_FORMAT='AVRO');

-- Join your stream and table
CREATE STREAM user_pageviews
  AS SELECT users_table.id AS userid, pageid, regionid, gender
    FROM pageviews_stream
    LEFT JOIN users_table ON pageviews_stream.userid = users_table.id
EMIT CHANGES;

--Filter a Stream
CREATE STREAM pageviews_region_like_89
  WITH (KAFKA_TOPIC='pageviews_filtered_r8_r9', VALUE_FORMAT='AVRO')
    AS SELECT * FROM user_pageviews
    WHERE regionid LIKE '%_8' OR regionid LIKE '%_9'
EMIT CHANGES;


-- Create a windowed view

CREATE TABLE pageviews_per_region_89 WITH (KEY_FORMAT='JSON')
  AS SELECT userid, gender, regionid, COUNT(*) AS numviews
    FROM pageviews_region_like_89
    WINDOW TUMBLING (SIZE 30 SECOND)
    GROUP BY gender, regionid, userid
    HAVING COUNT(*) > 1
EMIT CHANGES;

-- EL ESTADO DE LA TABLA EN ESE MOMENTO
SELECT * FROM pageviews_per_region_89
  WHERE userid = 'User_1' AND gender='FEMALE' AND regionid='Region_9';


SHOW STREAMS;
SHOW TABLES;
Mostrar Consultas Persistentes:
SHOW QUERIES;
Mostrar Información Detallada de un Stream o Tabla:
DESCRIBE purchases_stream;
DESCRIBE account_balances;
Paso 8: Eliminar Streams y Tablas
DROP STREAM purchases_stream;
DROP TABLE account_balances;


https://docs.confluent.io/platform/current/platform-quickstart.html#quickstart