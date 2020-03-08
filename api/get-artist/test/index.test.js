import { handler } from "../index";

test("lambda returns 200 when called", () => {
    handler({}, {}, (err, response) => {
        expect(err).toBe(null);
        expect(response.statusCode).toBe(200)
    });
});