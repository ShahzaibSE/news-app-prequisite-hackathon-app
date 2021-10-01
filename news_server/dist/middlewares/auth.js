"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.authToken = void 0;
function authToken(req, res, next) {
    const { email, password } = req.body;
    if (email == null && password == null) {
        res.status(403).send({
            status: false,
            resCode: 403,
            message: "Email and Password not provided",
            isError: true
        });
    }
    else {
        next();
    }
}
exports.authToken = authToken;
