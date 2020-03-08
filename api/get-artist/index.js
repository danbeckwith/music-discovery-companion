'use strict'

const AWS = require("aws-sdk");

exports.handler = function (event, context, callback) {
  console.log("Latest lambda invoked...");

  const secretsManager = new AWS.SecretsManager();

  secretsManager.getSecretValue({SecretId: "clientSecret"}, (err, data) => {
    if (err !== null) {
      callback(new Error("Failed to retrieve client secret..."));
    }

    console.log(`Retrieved secret [${data.Name}]...`);
  })

  let name = "world";

  if (event.queryStringParameters) {
    name = event.queryStringParameters.name;
  }
  
  const response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html; charset=utf-8'
    },
    body: `<p>Hello ${name}!</p>`
  }

  callback(null, response)
}