import express, { Request, Response } from "express";
// Models.
import { dbInjector } from "./dbInjector";

const profileModel = dbInjector().profile;

export const createProfile = async (req: Request, res: Response) => {
  const { uid, imageUrl, name, address, card_number } = req.body;
  //
  const existingProfile = await profileModel.findOne({ uid });
  if (existingProfile) {
    res.status(403).send({
      status: false,
      resCode: 403,
      message: "Profile already exists",
      isError: true,
    });
  } else {
    var newProfile = new profileModel({
      imageUrl,
      name,
      address,
      card_number,
    });
    newProfile.save((err, data) => {
      res.setHeader("Content-Type", "application/json");
      res.status(200).send({
        status: true,
        resCode: 200,
        message: "Profile created successfully",
        isError: false,
        data,
      });
    });
  }
};

export const updateProfile = async (req: Request, res: Response) => {
  const { uid, imageUrl, name, address, card_number } = req.body;
  //
  var updatedProfile = await profileModel.updateOne(
    { uid },
    { $set: { imageUrl, name, address, card_number } }
  );
  //
  if (updatedProfile) {
      res.status(200).send({
          status: true,
          resCode: 200,
          message: "Profile successfully edited",
          isError: false,
      });
  }else {
    res.status(400).send({
        status: false,
        resCode: 400,
        message: "Profile doesn't exist",
        isError: true,
    });
  }
};
