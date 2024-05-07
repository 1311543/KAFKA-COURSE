INTRODUCCIÓN COMMANDS

kafka-topics --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --partitions 3 --replication-factor 3 --create

# 1 PRODUCER CLIENT WITHOUT KEY
java -Dbrokers=kafka1:19092,kafka2:19093,kafka3:19094 -Dsleep=1 -DlimitMessages=1000 -DbroadPath=/tmp/data/data-streams.txt -DinputTopic=realtime-class-sesion3 -jar /tmp/data/OnlyTestProducerClientWithoutKey.jar
# usar consumer simple o consumer anatomy
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --from-beginning
kafka-consumer-groups --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --group grouptest --describe

# 1 PRODUCER CLIENT WITH A KEY
java -Dbrokers=kafka1:19092,kafka2:19093,kafka3:19094 -Dsleep=1 -DlimitMessages=100 -DbroadPath=/tmp/data/data-streams.txt -DinputTopic=realtime-class-sesion3 -jar /tmp/data/OnlyTestProducerClientWithKey.jar
# usar consumer simple o consumer anatomy
kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --topic realtime-class --from-beginning
java -DinputTopic=realtime-class-sesion3 -Dbrokers=kafka1:19092,kafka2:19093,kafka3:19094 -DgroupId=realtime-class-sesion3-groupid -DautoOffsetReset=earliest -jar /tmp/data/ConsumerClientAnatomy.jar
kafka-consumer-groups --bootstrap-server kafka1:19092,kafka2:19093,kafka3:19094 --group grouptest --describe

# CONSUMER ANATOMY
java -DinputTopic=realtime-class -Dbrokers=kafka1:19092,kafka2:19093,kafka3:19094 -DgroupId=grouptest -DautoOffsetReset=earliest -jar /tmp/data/ConsumerClientAnatomy.jar

# JAR EXECUTION MASSIVE MESSAGE MULTI THREAD
java -Dbrokers=kafka1:19092,kafka2:19093,kafka3:19094 -Dsleep=1 -Dthreads=3 -DlimitMessages=100 -DbroadPath=/tmp/data/data-streams.txt -DinputTopic=realtime-class-sesion3 -jar /tmp/data/MasiveMessageProductorClient.jar