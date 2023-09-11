const { Kafka } = require('kafkajs');
const mongoose = require('mongoose');
const config = require('./config');

const confluent = new Kafka(config.kafka);

// Connect to MongoDB Atlas
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

// Store to Mongo Atlas
saveDB = async ( topic, partition, message) => {
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



// Recieve Messages from Kafka

recieveMsgs = async () => {
  try {
    const consumer = confluent.consumer({ groupId: config.consumerGrp });
    await consumer.connect();
    await consumer.subscribe({ topic: config.topic, fromBeginning: true });
    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        console.log(`msg recieved : ${message.value.toString()} from topic ${topic}, partition ${partition}`);
        // Save to Mongo DB
        saveDB(topic, partition, message);
      },
    });
  } catch (error) {
    console.error('Error: Unable to connect to Kafka Cluster ::::: ', error);
  }
}


recieveMsgs().catch((error) => {
  console.error('Error in consumer ::::: ', error);
});