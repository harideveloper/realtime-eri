// Import dot.env for local development
require('dotenv').config();

module.exports = {
  kafka: {
    clientId: process.env.KAFKA_CLIENT_ID,
    brokers: [process.env.KAFKA_SERVERS],
    ssl: true, 
    sasl: {
      mechanism: process.env.KAFKA_SASL_MECHANISM, 
      username: process.env.KAFKA_SASL_USERNAME,
      password: process.env.KAFKA_SASL_PASSWORD,
    },
  },
  topic : process.env.KAFKA_TOPIC,
  consumerGrp: process.env.KAFKA_CONSUMER_GRP,

  mongodb: {
    connectionString: process.env.MONGODB_CONNECTION_STRING,
  },
};