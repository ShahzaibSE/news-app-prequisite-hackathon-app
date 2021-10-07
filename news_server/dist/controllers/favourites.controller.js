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
            res.setHeader("Content-Type", "application/json");
            res.status(400).send({
                status: false,
                resCode: 400,
                message: "No favourites found.",
                isError: true,
            });
        }
        else {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Favourites list",
                isError: false,
                data: favouritesList,
            });
        }
    }
    catch (err) {
        throw err;
    }
};
exports.getAllFavourites = getAllFavourites;
const addFavourite = async (req, res) => {
    const { uid, title, description, image, video, category, author, url, source, country, } = req.body;
    let existingFavourite = await favourite_model.findOne({ uid });
    if (existingFavourite) {
        res.status(403).send({
            status: false,
            resCode: 403,
            message: "Favourite already exists",
            isError: true,
        });
    }
    else {
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
exports.addFavourite = addFavourite;
const deleteFavourites = async (req, res) => {
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
    }
    else {
        res.setHeader("Content-Type", "application/json");
        res.status(424).send({
            status: false,
            resCode: 424,
            message: "Favourite could not be deleted",
            isError: true
        });
    }
};
exports.deleteFavourites = deleteFavourites;
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
