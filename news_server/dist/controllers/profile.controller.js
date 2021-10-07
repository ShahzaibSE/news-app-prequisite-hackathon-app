"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateProfile = exports.createProfile = exports.getProfile = void 0;
// Models.
const dbInjector_1 = require("./dbInjector");
const profileModel = dbInjector_1.dbInjector().profile;
const getProfile = async (req, res) => {
    const { uid } = req.params;
    var yourProfile = await profileModel.findOne({ uid });
    if (yourProfile) {
        res.status(200).send({
            status: true,
            resCode: 200,
            message: "Profile found successfully",
            isError: false,
            data: yourProfile
        });
    }
    else {
        res.status(200).send({
            status: false,
            resCode: 400,
            message: "Profile not found",
            isError: true
        });
    }
};
exports.getProfile = getProfile;
const createProfile = async (req, res) => {
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
    }
    else {
        let newProfile = new profileModel({
            uid,
            imageUrl,
            name,
            address,
            card_number,
        });
        let createdProfile = await newProfile.save();
        console.log("Profile created");
        console.log(createdProfile);
        res.setHeader("Content-Type", "application/json");
        res.status(200).send({
            status: true,
            resCode: 200,
            message: "Profile created successfully",
            isError: false,
        });
    }
};
exports.createProfile = createProfile;
const updateProfile = async (req, res) => {
    const { uid, imageUrl, name, address, card_number } = req.body;
    //
    var updatedProfile = await profileModel.updateOne({ uid }, { $set: { imageUrl, name, address, card_number } });
    //
    if (updatedProfile) {
        res.status(200).send({
            status: true,
            resCode: 200,
            message: "Profile successfully edited",
            isError: false,
        });
    }
    else {
        res.status(400).send({
            status: false,
            resCode: 400,
            message: "Profile doesn't exist",
            isError: true,
        });
    }
};
exports.updateProfile = updateProfile;
