const promise = jest.fn().mockResolvedValue(1)
const getSecretValue = jest.fn(() => ({ promise }))
jest.mock('aws-sdk/clients/secretsmanager', () => jest.fn().mockImplementation(() => ({ getSecretValue: getSecretValue })))

const { handler } = require("../index");
const SecretsManager = require('aws-sdk/clients/secretsmanager');

const manager = new SecretsManager();

// jest.mock('aws-sdk/clients/secretsmanager', () => {
//     return class SecretsManager {
//         getSecretValue() {
//             jest.fn();
//         }
//     }
// });

// console.log('manager :', manager);

// jest.mock('aws-sdk/clients/secretsmanager', () => {
//     return jest.fn().mockImplementation(() => {
//         return {
//             getSecretValue: jest.fn()
//         }
//     })
// })

beforeEach(() => {
    jest.clearAllMocks();
})

// test("lambda returns 200 when called", async() => {
//     const res = await handler({ event: { queryStringParameters : { name: "Dan "} }});
    
//     expect(res.statusCode).toBe(200)
// });

// test("should respond with Hello world! when name isn't specified", async() => {
//     const res = await handler({ event: {}});
    
//     expect(res.body).toBe("Hello World!")
// })

// test("should responsd with Hello <<name>>! when name is specified as a query param", async() => {
//     const res = await handler({ event: { queryStringParameters : { name: "Dan"} }});

//     // todo expect err to be null

//     expect(res.body).toBe("Hello Dan!")
// });

// test("should create a new instance of the secret manager", async() => {
//     const res = await handler({ event: { queryStringParameters : { name: "Dan"} }});

//     expect(SecretsManager).toHaveBeenCalledTimes(1);
// })

test("should call secrets manager to get client secret", async() => {
    const res = await handler({ event: { queryStringParameters : { name: "Dan"} }});

    expect(manager.getSecretValue).toHaveBeenCalledTimes(1);
})