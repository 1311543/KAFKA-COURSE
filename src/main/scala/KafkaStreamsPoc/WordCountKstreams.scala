package KafkaStreamsPoc

import java.util.concurrent.TimeUnit

import org.apache.kafka.streams.kstream.{Materialized, Named}
import org.apache.kafka.streams.scala.ImplicitConversions._
import org.apache.kafka.streams.scala.Serdes._
import org.apache.kafka.streams.scala._
import org.apache.kafka.streams.scala.kstream._
import org.apache.kafka.streams.{KafkaStreams, Topology}

object WordCountKstreams extends InitClass {
  println("Kstreams VM arguemtns :")
  println("-DinputTopic=inputTopic -DoutputTopic=outputTopic -Dbrokers=kafka1:19092,kafka2:19093,kafka3:19094 -DgroupId=test -DautoOffsetReset=latest")

  def main(args: Array[String]): Unit = {
    val properties = new KstreamProperties(brokers)
    val builder: StreamsBuilder = new StreamsBuilder

    val textLines = builder.stream[String, String](inputTopic)

    val wordCounts: KStream[String, String] =
      textLines
        .flatMapValues(textLine => {
          println("Receiving messages ...")
          textLine.toLowerCase.split("\\W+")
        })

    val wordCounts2: KGroupedStream[String, String] = wordCounts
      .groupBy((key, value) => value) // selector a function that computes a new KEY   for grouping

    val wordCount3: KTable[String, Long] = wordCounts2
      .count(Named.as("CountView"))(Materialized.as("counts-store-mx")) // Setting state store name*(Implicit Convertion)
    // The result is written into a local `KeyValueStore` (which is basically an ever-updating materialized view)
//      .count()(Materialized.`with`(Serdes.String, Serdes.Long)) // Internal name, typed convertions

    wordCount3.toStream.to(outputTopic)

    val topology: Topology = builder.build()
    println(topology.describe())

    val streams: KafkaStreams = new KafkaStreams(
      builder.build(),
      properties.getKstreamProperties("streams-wordcount"))

    streams.start()
    sys.ShutdownHookThread {
      streams.close(10, TimeUnit.SECONDS)
    }
  }
}