const SecretsManager = require('aws-sdk/clients/secretsmanager');

const manager = new SecretsManager();

const buildResponse = (statusCode, name) => ({
  statusCode,
  headers: {
      'Content-Type': 'text/html; charset=utf-8',
  },
  body: `Hello ${name}!`,
});

exports.handler = async (event) => {
  console.log("Invoking get-artist lamnda");

  const clientSecret = await manager.getSecretValue({SecretId: "clientSecret"}).promise()

  const name = event.queryStringParameters ? event.queryStringParameters.name : 'World';
  
  return buildResponse(200, name);
}