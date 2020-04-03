'use strict'

const SecretsManager = require('aws-sdk/clients/secretsmanager');

const buildResponse = (name) => ({
  statusCode: 200,
  headers: {
    'Content-Type': 'text/html; charset=utf-8'
  },
  body: `<p>Hello ${name}!</p>`
})

exports.handler = ({ event }) => {
  console.log("Invoking...");

  console.log('event :', JSON.stringify(event));

  SecretsManager.getSecretValue({SecretId: "clientSecret"}, (err, data) => {
    if (err) return err

    console.log("GOT IT");
  });

  let name = "World";

  if (event.queryStringParameters && event.queryStringParameters.name) {
    name = event.queryStringParameters.name
  }

  // const name = event.queryStringParameters.name || "world";
  
  return buildResponse(name);
}