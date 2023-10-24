const { Kafka } = require('kafkajs');
const mongoose = require('mongoose');
const config = require('./config');

const confluent = new Kafka(config.kafka);

const consumerByPartition = true;
//const lagInterval = 100;

// Connect to MongoDB Atlas

if (!config.mongodb.skipSaveMsg) {
  mongoose.connect(config.mongodb.connectionString, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
  const messageSchema = new mongoose.Schema({
    topic: String,
    partition: Number,
    value: String,
  });

  const Message = mongoose.model('Message', messageSchema);
}


consumeMsgsByPartition = async () => {
  try {
  const consumer = confluent.consumer({ groupId: config.consumerGrp });
  await consumer.connect();
  await consumer.subscribe({ topic: config.topic, partitions: [config.partition], fromBeginning: true });
  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      console.log(`consuming msg by partition : ${message.value.toString()} from topic ${topic}, partition ${partition}`);
      // console.log("LAG INTERVAL === "+config.lagInterval)
      await sleep(config.lagInterval);

      // Save to Mongo DB
      if (!config.mongodb.skipSaveMsg) {
        console.log("Info: Messages NOT stored in the Atlas")
        saveDB(topic, partition, message);
      }
    },
  });
  } catch (error) {
    console.error('Error: Unable to consume message by parition ::::: ', error);
  }
}


consumeMsgsByTopic = async () => {
  try {
  const consumer = confluent.consumer({ groupId: config.consumerGrp });
    await consumer.connect();
    await consumer.subscribe({ topic: config.topic, fromBeginning: true });
    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        console.log(`consuming msg by topic : ${message.value.toString()} from topic ${topic}, partition ${partition}`);
        // Save to Mongo DB
        if (!config.mongodb.skipSaveMsg) {
          console.log("Info: Messages NOT stored in the Atlas")
          saveDB(topic, partition, message);
        }
      },
    });
  } catch (error) {
    console.error('Error: Unable to consume message by topic ::::: ', error);
  }
}



// Store to Mongo Atlas
saveDB = async (topic, partition, message) => {
  const dbMsg = new Message({
    topic,
    partition,
    value: message.value.toString(),
  });

  try {
    await dbMsg.save();
    console.log(`Info : msg saved to Mongo Atlas :::::  ${dbMsg.value}`);
  } catch (error) {
    console.error('Error: Unable to save message to Mongo Atlas ::::: ', error);
  }
}

// 


// Recieve Messages from Kafka

recieveMsgs = async () => {
  try {
    consumerByPartition ? consumeMsgsByPartition() : consumeMsgsByTopic();
  } catch (error) {
    console.error('Error: Unable to connect to Kafka Cluster ::::: ', error);
  }
}


async function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}


recieveMsgs().catch((error) => {
  console.error('Error in consumer ::::: ', error);
});