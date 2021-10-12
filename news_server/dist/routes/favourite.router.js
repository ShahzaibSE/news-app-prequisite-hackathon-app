"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
// Controller.
const favourites_controller_1 = require("./../controllers/favourites.controller");
const favourite_router = express_1.Router();
favourite_router.get('/list', favourites_controller_1.getAllFavourites);
favourite_router.post("/add", favourites_controller_1.addFavourite);
favourite_router.delete("/delete/:_id", favourites_controller_1.deleteFavourites);
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
exports.default = favourite_router;
