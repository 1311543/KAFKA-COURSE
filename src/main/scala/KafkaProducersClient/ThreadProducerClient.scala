package KafkaProducersClient

import com.mashape.unirest.http.Unirest
import org.apache.kafka.clients.producer.{Callback, KafkaProducer, ProducerRecord, RecordMetadata}

class ThreadProducerClient(topic: String,
                           producer: KafkaProducer[String, String],
                           limitMessages: String,
                           broadPath: String,
                           sleep: String) extends Runnable {

  override def run(): Unit = {
    val reader = new ReaderSource
//    val broadList: Array[String] = reader.readBroad(broadPath)
  val broadList: Array[String] = reader.readBroad("/tmp/data/data-streams.txt")
    var limit = 0
    val until = limitMessages.toInt
    broadList.foreach(println(_))

    while (limit < until) {
      broadList.foreach {
        message => {
          limit += 1
          println(limit)
          Thread.sleep(sleep.toInt)
          println(message)
//          Unirest
//            .post("https://api.powerbi.com/beta/c4a66c34-2bb7-451f-8be1-b2c26a430158/datasets/d7888ac7-012d-4861-a3bd-c5c75f4e9ccd/rows?key=78W8lYzTYK6wT26Oa5HeZqVbV4Pb%2Fl6LxEtl0ixyOL88Xjpctpf%2Be83oQKCXi4MPCRE7paufv0wynsN1jLBC%2Fw%3D%3D")
//            .header("Content-Type", "application/json")
//            .body(message)
//            .asJsonAsync()

          val record: ProducerRecord[String, String] = new ProducerRecord[String, String](topic, message)

          producer.send(record, new Callback {
            override def onCompletion(recordMetadata: RecordMetadata, e: Exception): Unit = {
              if (e != null) {
                println(s"Cannot publish to $topic. Caused by: ${e.getMessage}", e)
              }
              else {
                val offset = recordMetadata.offset()
                val partition = recordMetadata.partition()
                val key = recordMetadata.topic()
                println(s"record has already sent to kafka:topic=$topic, partition=$partition, offset=$offset");
              }
            }
          })
          producer.send(record)
        }
      }
    }
    println("ending while")
    producer.close()
  }
}

