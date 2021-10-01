import express, {Router} from "express";
import app from "./../server";
// Controller.
import {
    login, signup
} from "./../controllers/user.controller";

const user_router: Router = Router();

user_router.post("/login", login);
user_router.post("/signup", signup);
// user_router.post("/test", (req,res)=>{
//     res.status(200).send("Test successful");
// })
// user_router.get("/test", signup)
// user_router.post('/test', async (req: express.Request,res: express.Response) => {
//     const {firstname, lastname, email, password} = req.body;
//     console.log('User Credientials - Sign Up');
//     console.log(req.body);
//     //
//     if(!firstname && firstname == "" &&
//         !lastname && lastname == null &&
//         !email && email == null && !password && password == null
//     ){
//         res.status(400).send({
//             status: false,
//             resCode: 400,
//             message: "Please provide all detail",
//             isError: true,
//         });
//     }else {
//         res.status(200).send({
//             status: true,
//             resCode: 200,
//             message: "Sign Up successful",
//             isError: false,
//         });
//     }
// })
export default user_router;