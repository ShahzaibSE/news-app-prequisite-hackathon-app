import { profile } from "console";
import express, { Request, Response } from "express";
// Models.
import { dbInjector } from "./dbInjector";

const profileModel = dbInjector().profile;

export const getProfile = async (req: Request, res: Response) => {
  const { uid } = req.params;
  var yourProfile = await profileModel.findOne({ uid });
  if (yourProfile) {
    res.status(200).send({
      status: true,
      resCode: 200,
      message: "Profile found successfully",
      isError: false,
      data: yourProfile,
    });
  } else {
    res.status(200).send({
      status: false,
      resCode: 400,
      message: "Profile not found",
      isError: true,
    });
  }
};

export const createProfile = async (req: Request, res: Response) => {
  const { uid, imageUrl, name, address, card_number } = req.body;
  //
  const existingProfile = await profileModel.findOne({ uid });
  console.log("Existing profile");
  console.log(existingProfile);
  if (existingProfile) {
    var profileObj = {};
    if (imageUrl == "" && existingProfile["imageUrl"] != null) {
      profileObj = { uid, imageUrl: existingProfile["imageUrl"] };
    }
    if (name == "" && existingProfile["name"] != null) {
      console.log("Name not provided");
      profileObj = { uid, imageUrl, name: existingProfile["name"] };
    }
    if (address == "" && existingProfile["address"] != null) {
      profileObj = { uid, imageUrl, name, address: existingProfile["address"] };
    }
    if (card_number == "" && existingProfile["card_number"] != null) {
      profileObj = {
        uid,
        imageUrl,
        name,
        address,
        card_number: existingProfile["card_number"],
      };
    }
    if(Object.keys(profileObj).length > 1) {
      console.log("with few keys updated - Profile Obj");
      console.log(profileObj)
      let updatedProfile = await profileModel.updateOne(
        { uid },
        // { $set: { imageUrl, name, address, card_number } }
        { $set: { profileObj } }
      );
      if (updatedProfile) {
        res.status(200).send({
          status: true,
          resCode: 200,
          message: "Profile updated successfully",
          isError: false,
        });
      } else {
        res.status(400).send({
          status: false,
          resCode: 400,
          message: "Error while updating profile",
          isError: true,
        });
      }
    } else {
      // console.log('Updating profile');
      // console.log(profileObj);
      let updatedProfile = await profileModel.updateOne(
        { uid },
        // { $set: { imageUrl, name, address, card_number } }
        { $set: {uid, imageUrl, name, address, card_number} }
      );
      if (updatedProfile) {
        res.status(200).send({
          status: true,
          resCode: 200,
          message: "Profile updated successfully",
          isError: false,
        });
      } else {
        res.status(400).send({
          status: false,
          resCode: 400,
          message: "Error while updating profile",
          isError: true,
        });
      }
    }
  } else {
    let newProfile = new profileModel({
      uid,
      imageUrl,
      name,
      address,
      card_number,
    });
    let createdProfile = await newProfile.save();
    res.setHeader("Content-Type", "application/json");
    res.status(200).send({
      status: true,
      resCode: 200,
      message: "Profile created successfully",
      isError: false,
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
  } else {
    res.status(400).send({
      status: false,
      resCode: 400,
      message: "Profile doesn't exist",
      isError: true,
    });
  }
};
