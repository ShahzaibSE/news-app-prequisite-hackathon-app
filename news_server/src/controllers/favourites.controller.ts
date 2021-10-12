import mongoose from "mongoose";
import express, { Request, Response } from "express";
// Models
import { dbInjector } from "./dbInjector";

const favourite_model = dbInjector().favourite;

export const getAllFavourites = async (req: Request, res: Response) => {
  try {
    const favouritesList: Array<any> = await favourite_model.find({});
    if (!favouritesList) {
      res.setHeader("Content-Type", "application/json");
      res.status(400).send({
        status: false,
        resCode: 400,
        message: "No favourites found.",
        isError: true,
      });
    } else {
      res.setHeader("Content-Type", "application/json");
      res.status(200).send({
        status: true,
        resCode: 200,
        message: "Favourites list",
        isError: false,
        data: favouritesList,
      });
    }
  } catch (err) {
    throw err;
  }
};

export const addFavourite = async (req: Request, res: Response) => {
  const {
    uid,
    title,
    description,
    image,
    video,
    category,
    author,
    url,
    source,
    country,
  } = req.body;
  let existingFavourite = await favourite_model.findOne({ title });
  if (existingFavourite) {
    res.status(403).send({
      status: false,
      resCode: 403,
      message: "Favourite already exists",
      isError: true,
    });
  } else {
    let newFavourite = new favourite_model({
      uid,
      title,
      description,
      image,
      video,
      category,
      author,
      url,
      source,
      country,
    });
    newFavourite.save((err, data) => {
      res.setHeader("Content-Type", "application/json");
      res.status(200).send({
        status: true,
        resCode: 200,
        message: "Favourite added successfully",
        isError: false,
        data,
      });
    });
  }
};

export const deleteFavourites = async (req: Request, res: Response) => {
  var deletedDocument = await favourite_model.deleteOne({
    _id: req.params._id,
  });
  if (deletedDocument) {
    res.setHeader("Content-Type", "application/json");
    res.status(200).send({
      status: true,
      resCode: 200,
      message: "Favourite deleted successfully",
      isError: false,
    });
  }else {
    res.setHeader("Content-Type", "application/json");
    res.status(424).send({
        status: false,
        resCode: 424,
        message: "Favourite could not be deleted",
        isError: true
    });
  }
};

// export const addFavourite = async (req: Request, res: Response) => {
//     const {uid, favourites} = req.body;
//     favourite_model.findOne({uid}, (err, data)=>{
//         if(err) {
//             res.setHeader('Content-Type', 'application/json');
//             res.status(500).send({
//                 status: false,
//                 resCode: 500,
//                 message: "Internal server error",
//                 isError: true
//             });
//         }else if(data){
//             favourite_model.updateOne({uid}, {$push:{favourites:favourites}}, (err, data)=>{
//                 if (err) {
//                     res.setHeader('Content-Type', 'application/json');
//                     res.status(400).send({
//                         status: false,
//                         resCode: 400,
//                         message: "Favourites not updated",
//                         isError: true
//                     });
//                 }else {
//                     res.setHeader('Content-Type', 'application/json');
//                     res.status(200).send({
//                         status: true,
//                         resCode: 200,
//                         message: "Favourite updated successfully",
//                         isError: false
//                     })
//                 }
//             })
//         }else {
//             let newFavourite = new favourite_model({
//                 uid,
//                 favourites
//             });
//             newFavourite.save((err, data)=>{
//                 res.setHeader('Content-Type', 'application/json');
//                     res.status(200).send({
//                         status: true,
//                         resCode: 200,
//                         message: "Favourite added successfully",
//                         isError: false,
//                         data
//                 })
//             });
//         }
//     })

// }
