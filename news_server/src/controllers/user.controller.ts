import mongoose from "mongoose";
import express from "express";
import bcrypt from "bcrypt";
// Model.
import { dbInjector } from "./dbInjector";

const user_model = dbInjector().user;
// Bcrypt configuration.
const saltRounds = 10;

export const login = async (req: express.Request, res: express.Response) => {
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
  } else {
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

export const signup = async (req: express.Request, res: express.Response) => {
  const { firstname, lastname, email, password } = req.body;
  //
  if (
    !firstname &&
    firstname == "" &&
    !lastname &&
    lastname == null &&
    !email &&
    email == null &&
    !password &&
    password == null
  ) {
    res.status(400).send({
      status: false,
      resCode: 400,
      message: "Please provide all detail",
      isError: true,
    });
  } else {
    const existingUser = await user_model.findOne({ email });
    if (existingUser) {
      res.status(409).send({
        status: true,
        resCode: 409,
        message: "User already exists",
        isError: false,
      });
    } else {
      let new_user_credientials = {
        firstname,
        lastname,
        email,
        password: (await bcrypt.hash(password, saltRounds)).toString(),
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
        } else {
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
