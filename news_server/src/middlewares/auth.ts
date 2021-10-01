import express from "express";
import mongoose from "mongoose";

export function authToken(req,res,next){
    const {email, password} = req.body;
    if (email == null && password == null) {
        res.status(403).send(
            {
                status: false,
                resCode: 403,
                message: "Email and Password not provided",
                isError: true
            }
        );
    }else {
        next();
    }
}