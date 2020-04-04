const buildResponse = (statusCode, name) => ({
  statusCode,
  headers: {
      'Content-Type': 'text/html; charset=utf-8',
  },
  body: `Hello ${name}!`,
});

exports.handler = async (event) => {
  console.log("Invoking auth lamnda");

  const name = event.queryStringParameters ? event.queryStringParameters.name : 'World';
  
  return buildResponse(200, name);
}