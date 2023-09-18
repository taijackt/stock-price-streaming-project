# Stock price streaming project by using Kafka and AWS
Stock price streaming project using Apache Kafka and AWS

<img src="https://images.g2crowd.com/uploads/product/image/social_landscape/social_landscape_809aa88d3571ee805a47d8fb156ba412/apache-kafka.jpg" width="300"/>

### Background
1. This data engineering project is aim to make a streaming data pipeline by using Apache kafka and AWS services (S3 and EC2), to stream stock price end-to-end from data source to aws glue.
2. This project will use a csv file from [Kaggle.com](https://github.com/taijackt/stock-price-streaming-project/blob/main/screenshots/project_diagram.jpg?raw=true) to simulate the data source.

### Project diagram
![diagram](https://github.com/taijackt/stock-price-streaming-project/blob/main/screenshots/project_diagram.jpg?raw=true)

### Prerequisite
1. Download the csv file from [Kaggle.com](https://www.kaggle.com/datasets/nelgiriyewithana/world-stock-prices-daily-updating), we use it to simulate the data source.
2. Python in local computer
3. AWS account.

### Install and start kafka
1. Create a new EC2 instance on AWS. Remote to it.
```bash
# download kafka 
wget https://downloads.apache.org/kafka/3.5.1/kafka_2.12-3.5.1.tgz
tar -xvf kafka_2.12-3.5.1.tgz
cd kafka_2.12-3.5.1
```

2. Install java
```bash
# install java
sudo yum install java-1.8.0-openjdk 
# if the command above doesn't work
sudo yum install java
```

3. Start zookeeper
```bash
# I use screen so that we don't need to create a new remote window.
screen -S zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties
```

4. Start kafka
- Before start the bootstrap server, we need to modify `config/sevrer.properties`, to make it launch on public.
```bash
screen -S kafka-server
bin/kafka-server-start.sh config/server.properties
```

5. Create a new topic on kafka
```bash
/bin/kafka-topics.sh --create --topic stock-data --bootstrap-server {public_ip_of_ec2}:9092
```

### Producer `notebook/producer.ipynb`
- We use a python file in local computer to act as a producer in this project.
- The notebook file will read the csv file, keep only the useful columns and send it to kafka broker.

### Consumer `notebook/consumer.ipynb`
- This notebook will act as a consumer, it will read the data from broker and upload it to a s3 bucket using the boto3 library.

### Process after the data is uploaded to s3.
1. Data in s3 are save in single json file (1 record save as 1 json).
<img src="https://github.com/taijackt/stock-price-streaming-project/blob/main/screenshots/s3.jpg" width="500"/>

3. Then we use a glue crawler to create a database base on files in bucket.

4. Now we can use Athena to query the data
<img src="https://github.com/taijackt/stock-price-streaming-project/blob/main/screenshots/athena.jpg" width="500"/>
