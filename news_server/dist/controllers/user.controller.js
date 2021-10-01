"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.signup = exports.login = void 0;
const bcrypt_1 = __importDefault(require("bcrypt"));
// Model.
const dbInjector_1 = require("./dbInjector");
const user_model = dbInjector_1.dbInjector().user;
// Bcrypt configuration.
const saltRounds = 10;
const login = async (req, res) => {
    const { email, password } = req.body;
    console.log("User Credientials - Log In");
    console.log(req.body);
    if (!email && email == "" && !password && password == "") {
        return res.status(400).send({
            status: false,
            resCode: 400,
            message: "No email or password found",
            isError: true,
        });
    }
    else {
        var user = await user_model.findOne({ email, password });
        console.log(typeof user);
        return res.status(200).send({
            status: true,
            resCode: 200,
            message: "Login successful",
            isError: false,
        });
    }
};
exports.login = login;
const signup = async (req, res) => {
    const { firstname, lastname, email, password } = req.body;
    //
    if (!firstname &&
        firstname == "" &&
        !lastname &&
        lastname == null &&
        !email &&
        email == null &&
        !password &&
        password == null) {
        res.status(400).send({
            status: false,
            resCode: 400,
            message: "Please provide all detail",
            isError: true,
        });
    }
    else {
        const existingUser = await user_model.findOne({ email });
        if (existingUser) {
            res.status(409).send({
                status: true,
                resCode: 409,
                message: "User already exists",
                isError: false,
            });
        }
        else {
            let new_user_credientials = {
                firstname,
                lastname,
                email,
                password: (await bcrypt_1.default.hash(password, saltRounds)).toString(),
                createdAt: new Date().toISOString(),
            };
            const newUser = new user_model(new_user_credientials);
            newUser.save().then((response) => {
                if (response) {
                    res.status(200).send({
                        status: true,
                        resCode: 200,
                        message: "Sign Up successful",
                        isError: false,
                    });
                }
                else {
                    res.status(400).send({
                        status: false,
                        resCode: 400,
                        message: "Couldn't create user due to error.",
                        isError: false,
                    });
                }
            });
        }
    }
};
exports.signup = signup;
