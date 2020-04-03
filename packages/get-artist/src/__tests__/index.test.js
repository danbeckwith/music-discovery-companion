const promise = jest.fn().mockResolvedValue(100)
const mockGetSecretValue = jest.fn(() => ({ promise }))
jest.mock('aws-sdk/clients/secretsmanager', () => jest.fn().mockImplementation(() => ({ getSecretValue: mockGetSecretValue })))

const { handler } = require("../index");
const SecretsManager = require('aws-sdk/clients/secretsmanager');

const manager = new SecretsManager();

beforeEach(() => {
    jest.clearAllMocks();
})

it("lambda returns 200 when called", async() => {
    const res = await handler({ event: { queryStringParameters : { name: "Dan "} }});

    expect(res.statusCode).toBe(200)
});

it("should respond with Hello world! when name isn't specified", async() => {
    const res = await handler({});
    
    expect(res.body).toBe("Hello World!")
})

it("should respond with Hello <<name>>! when name is specified as a query param", async () => {
    const res = await handler({ queryStringParameters: { name: 'Dan' } });

    // todo expect err to be null

    expect(res.body).toBe("Hello Dan!")
});

it("should call secrets manager to get client secret", async() => {
    const res = await handler({ queryStringParameters: { name: 'Dan' } });

    expect(manager.getSecretValue).toHaveBeenCalledTimes(1);
});