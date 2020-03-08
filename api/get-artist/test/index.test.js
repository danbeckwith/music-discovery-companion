import { handler } from "../index";
import AWS from 'aws-sdk'

jest.mock('aws-sdk', () => {
    return {
        SecretsManager: jest.fn().mockImplementation(() => {
            return {
                getSecretValue: jest.fn()
            }
        })
    }
});

beforeEach(() => {
    AWS.SecretsManager.mockClear();
})

test("lambda returns 200 when called", () => {
    handler({}, {}, (err, response) => {
        expect(err).toBeNull();
        expect(response.statusCode).toBe(200)
    });
});

test("should responsd with Hello world! when name isn't specified", () => {
    handler({}, {}, (err, response) => {
        expect(err).toBe(null);
        expect(response.body).toBe("<p>Hello world!</p>")
    })
})

test("should responsd with Hello <<name>>! when name is specified as a query param", () => {
    const event = {
        queryStringParameters: {
            name: "Dan"
        }
    }

    handler(event, {}, (err, response) => {
        expect(err).toBe(null);
        expect(response.body).toBe("<p>Hello Dan!</p>");
    });
});

test("should create secret manager class instance", () => {
    handler({}, {}, (err, response) => {
        expect(AWS.SecretsManager).toHaveBeenCalledTimes(1);
    })
});

// test("should call secrets manager to get client secret", () => {
//     handler({}, {}, (err, response) => {
//         const cb = jest.fn
//         expect(AWS.SecretsManager.getSecretValue).toHaveBeenCalledWith({
//             SecretId: "clientSecret", cb
//         });
//     })
// })