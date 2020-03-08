'use strict'

exports.handler = function (event, context, callback) {
    console.log(JSON.stringify(`Invoked lambda...`))
    
    // context.succeed('Success!')
    // context.fail('Failed!')
    
    console.log("Lambda invoked...");

    const response = {
        statusCode: 200,
        headers: {
          'Content-Type': 'text/html; charset=utf-8'
        },
        body: '<p>Hello world!</p>'
    }

    callback(null, response)
}