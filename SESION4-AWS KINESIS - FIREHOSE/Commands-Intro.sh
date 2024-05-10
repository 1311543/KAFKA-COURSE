# AMAZON KINESIS
aws kinesis put-record \
    --stream-name data-stream-source-topic \
    --partition-key "1" \
    --data "hola mundo"
	
	
aws kinesis put-record \
    --stream-name data-stream-source-topic \
    --partition-key "1" \
    --data "{"type": {"device": "mobile","event": "user_clicked_submit_button"},"customer_id": "1234567890","event_timestamp": 1565382027,"region": "pdx"}"
	

# AMAZON FIREHOSE

Dynamic partitioning
S3 bucket prefix - optional

S3 bucket error output prefix - optional

S3 compression and encryption
KinesisFirehoseServiceRole-KDS-S3-CONNEC-us-west-2-1697525968188

Dynamic partitioning
ENABLE
Inline parsing for JSON - ENABLE

{ 
    "TICKER_SYMBOL": "QXZ",
    "SECTOR": "HEALTHCARE",
    "CHANGE": -0.05,
    "PRICE": 84.51
}


Key name  JQ expression
SECTOR	.SECTOR

my-delivery-stream-prefix/!{partitionKeyFromQuery:SECTOR}/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/

streaming/data/SECTOR=HEALTHCARE/year=2023/month=11/day=18/
streaming/data/SECTOR=LOGISCTIC/year=2023/month=11/day=18/
streaming/data/SECTOR=RRHH/year=2023/month=11/day=18/