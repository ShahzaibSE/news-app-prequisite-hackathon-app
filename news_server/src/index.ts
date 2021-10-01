import app from "./server";
import * as express from "express";

const port = Number(process.env.PORT || 3000);

const server = app.listen(port, ()=>{
    console.log("|======================================|");
    console.log(`|=====================Server started on ${port}=================|`);
    console.log("|======================================|");
})