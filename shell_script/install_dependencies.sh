# download data set at kaggle
https://www.kaggle.com/datasets/nelgiriyewithana/world-stock-prices-daily-updating

# download kafka 
wget https://downloads.apache.org/kafka/3.5.1/kafka_2.12-3.5.1.tgz
tar -xvf kafka_2.12-3.5.1.tgz

# install java
sudo yum install java-1.8.0-openjdk 
# if the command above doesn't work
sudo yum install java

#cd to kafka directory
cd kafka_2.12-3.5.1

# Start zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties

# Start kafka server
bin/kafka-server-start.sh config/server.properties

#Create topic on kafka
/bin/kafka-topics.sh --create --topic stock-data --bootstrap-server {public_ip_of_ec2}:9092

#Run consumer and producer for testing
bin/kafka-console-producer.sh --topic stock-data --bootstrap-server {public_ip_of_ec2}:9092
bin/kafka-console-consumer.sh --topic stock-data --bootstrap-server {public_ip_of_ec2}:9092 --from-beginning