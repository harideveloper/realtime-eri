// producer.js
const { Kafka } = require('kafkajs');
const config = require('./config');


//const kafka = new Kafka(config.kafka);
const confluent = new Kafka(config.kafka);

const msgCount = 100;

async function streamMsgs() {
  const producer = confluent.producer();

  await producer.connect();

  try {
    const topic = config.topic; // Replace with your Kafka topic name

    // Stream messages
    for (let i = 0; i < msgCount ; i++) {
      const message = {
        key: `Dark Knight -${i}`,
        value: `Dark Knight -:${i}`,
      };

    await producer.send({
      topic,
      messages: [message],
    });

    console.log('Message sent successfully ::::: '+message.value);
    }
  } catch (error) {
    console.error('Error sending message ::::: ', error);
  } finally {
    await producer.disconnect();
  }
}


streamMsgs().catch((error) => {
  console.error('Error in producer:', error);
});
