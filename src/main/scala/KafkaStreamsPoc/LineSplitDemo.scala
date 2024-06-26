package KafkaStreamsPoc

import java.util.concurrent.TimeUnit

import org.apache.kafka.streams.scala.ImplicitConversions._
import org.apache.kafka.streams.scala.Serdes._
import org.apache.kafka.streams.scala.StreamsBuilder
import org.apache.kafka.streams.scala.kstream.KStream
import org.apache.kafka.streams.{KafkaStreams, Topology}

object LineSplitDemo extends InitClass {
  def main(args: Array[String]): Unit = {
    val properties = new KstreamProperties(brokers)

    val builder: StreamsBuilder = new StreamsBuilder

    val records: KStream[String, String] = builder.stream[String, String](inputTopic)
    val words: KStream[String, String] = records.flatMapValues(textLine => {
      textLine.toLowerCase.split("\\W+")
    })

    words.peek((key, value) => println(value))
//    records.to(outputTopic)
    words.to(outputTopic)

    val topology: Topology = builder.build()
    println(topology.describe())

    val streams: KafkaStreams = new KafkaStreams(
      builder.build(),
      properties.getKstreamProperties("streams-linesplit"))

    streams.start()
    sys.ShutdownHookThread {
      streams.close(100, TimeUnit.SECONDS)
    }
  }
}
