'use strict'

exports.handler = function (event, context, callback) {
  console.log("Latest lambda invoked...");

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