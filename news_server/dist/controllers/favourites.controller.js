"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteFavourites = exports.addFavourite = exports.getAllFavourites = void 0;
// Models
const dbInjector_1 = require("./dbInjector");
const favourite_model = dbInjector_1.dbInjector().favourite;
const getAllFavourites = async (req, res) => {
    try {
        const favouritesList = await favourite_model.find({});
        if (!favouritesList) {
            res.setHeader('Content-Type', 'application/json');
            res.status(400).send({
                status: false,
                resCode: 400,
                message: "No favourites found.",
                isError: true
            });
        }
        else {
            res.setHeader('Content-Type', 'application/json');
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Favourites list",
                isError: false,
                data: favouritesList
            });
        }
    }
    catch (err) {
        throw err;
    }
};
exports.getAllFavourites = getAllFavourites;
const addFavourite = async (req, res) => {
    const { uid, favourites } = req.body;
    favourite_model.findOne({ uid }, (err, data) => {
        if (err) {
            res.setHeader('Content-Type', 'application/json');
            res.status(500).send({
                status: false,
                resCode: 500,
                message: "Internal server error",
                isError: true
            });
        }
        else if (data) {
            favourite_model.updateOne({ uid }, { $push: { favourites: favourites } }, (err, data) => {
                if (err) {
                    res.setHeader('Content-Type', 'application/json');
                    res.status(400).send({
                        status: false,
                        resCode: 400,
                        message: "Favourites not updated",
                        isError: true
                    });
                }
                else {
                    res.setHeader('Content-Type', 'application/json');
                    res.status(200).send({
                        status: true,
                        resCode: 200,
                        message: "Favourite updated successfully",
                        isError: false
                    });
                }
            });
        }
        else {
            let newFavourite = new favourite_model({
                uid,
                favourites
            });
            newFavourite.save((err, data) => {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send({
                    status: true,
                    resCode: 200,
                    message: "Favourite added successfully",
                    isError: false,
                    data
                });
            });
        }
    });
};
exports.addFavourite = addFavourite;
const deleteFavourites = async (req, res) => {
};
exports.deleteFavourites = deleteFavourites;
