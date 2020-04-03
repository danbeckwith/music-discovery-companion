import { handler } from "../index";
const SecretsManager = require('aws-sdk/clients/secretsmanager');

// jest.mock('aws-sdk', () => {
//     return {
//         SecretsManager: jest.fn().mockImplementation(() => ({
//             getSecretValue: mockGetSecretValue
//         }))
//     }
// });

const mockGetSecretValue = jest.fn()

jest.mock('aws-sdk/clients/secretsmanager', () => {
    return {
        getSecretValue: jest.fn().mockResolvedValue("42")
    }
});

beforeEach(() => {
    jest.clearAllMocks();
})

test("lambda returns 200 when called", () => {
    const res = handler({ event: { queryStringParameters : { name: "Dan "} }});
    
    expect(res.statusCode).toBe(200)
});

test("should respond with Hello world! when name isn't specified", () => {
    const res = handler({ event: {}});
    
    expect(res.body).toBe("<p>Hello World!</p>")
    // handler({}, {}, (err, response) => {
    //     expect(err).toBe(null);
    //     expect(response.body).toBe("<p>Hello world!</p>")
    // })
})

test("should responsd with Hello <<name>>! when name is specified as a query param", () => {
    const res = handler({ event: { queryStringParameters : { name: "Dan"} }});

    // todo expect err to be null

    expect(res.body).toBe("<p>Hello Dan!</p>")
});

test("should call secrets manager to get client secret", () => {

    const res = handler({ event: { queryStringParameters : { name: "Dan"} }});

    expect(SecretsManager.getSecretValue).toHaveBeenCalledTimes(1);
})