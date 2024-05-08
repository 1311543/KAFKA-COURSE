ProducerClient
VM options : -DinputTopic=realtime-class -Dbrokers=localhost:9092,localhost:9093,localhost:9094
Progrmas arguments : 0.0.0.0:9092 kafkainput2 test2
Main class: KafkaProducersClient.ProducerClient

ConsumerClient
VM options : -DinputTopic=sink-transaction -Dbrokers=localhost:9092,localhost:9093,localhost:9094 -DgroupId=consumer-group-escritura-dmc -DautoOffsetReset=latest
Progrmas arguments : 0.0.0.0:9092 kafkainput2 test2
Main class: KafkaSingleConsumerClient.ConsumerClient

OnlyTestProducerClient
VM options : -DinputTopic=realtime-class -Dbrokers=localhost:9092,localhost:9093,localhost:9094
Main class: KafkaProducersClient.OnlyTestProducerClient

LineSplit
VM options : -DinputTopic=inputTopic -DoutputTopic=outputTopic -Dbrokers=localhost:9092 -DgroupId=test -DautoOffsetReset=earliest
KafkaStreamsPoc.LineSplitDemo

PIPE
VM options : -DinputTopic=inputTopic -DoutputTopic=outputTopic -Dbrokers=localhost:9092 -DgroupId=test -DautoOffsetReset=latest
Main class: KafkaStreamsPoc.PipeDemo

KafkaAdminClient.KafkaAdminClient
VM options : -DinputTopic=mx-transaction -Dbrokers=localhost:9092 -Doption=1 -Dthreads=1 -DreplicationFactor=1
Main class: KafkaAdminClient.KafkaTopicsAdmin


consumerGroupClient
VM Options: -DinputTopic=mx-transaction -Dbrokers=localhost:9092 -Dthreads=5 -DgroupId=test -DautoOffsetReset=earliest
Main class: KafkaGroupConsumerClient.GroupConsumerClient

StatefulOperation
VM Options: -DinputTopic=RawDomesticRetailSalesTopic -DoutputTopic=DomesticRevenueByDepartmentTopic -Dbrokers=localhost:9092 -DgroupId=test -DautoOffsetReset=earliest
Main class: KafkaStreamsPoc.StatefulOperations


LineSplit
vm options: -DinputTopic=inputTopic -DoutputTopic=outputTopic -Dbrokers=localhost:9092 -DgroupId=test -DautoOffsetReset=earliest
Main class: KafkaStreamsPoc.LineSplitDemo

MassiveMessageProductorClient
vm options: -Dbrokers=localhost:9092,localhost:9093,localhost:9094 -Dsleep=0 -Dthreads=3 -DlimitMessages=100 -DbroadPath=data-streams.txt -DinputTopic=realtime-class-11
Main class: KafkaProducersClient.MasiveMessageProductorClient

