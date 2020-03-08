import { handler } from "../index";

test("lambda returns 200 when called", () => {
    handler({}, {}, (err, response) => {
        expect(err).toBe(null);
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