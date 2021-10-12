"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Profile = exports.Favourite = exports.User = void 0;
const mongoose_1 = require("mongoose");
exports.User = new mongoose_1.Schema({
    firstname: {
        type: String,
        required: true
    },
    lastname: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
});
// export const Favourite = new Schema({
//     uid: {
//         type: String,
//         required: true
//     },
//     favourites: {
//         type: Array,
//         default: [{}]
//     }
// });
exports.Favourite = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    title: {
        type: String
    },
    description: {
        type: String,
        // required: true
    },
    image: {
        type: String,
        // required: true
    },
    video: {
        type: String
    },
    time: {
        type: String
    },
    published_at: {
        type: String
    },
    category: {
        type: String,
        // required:true
    },
    author: {
        type: String
    },
    url: {
        type: String
    },
    source: {
        type: String
    },
    country: {
        type: String
    },
    createdAt: {
        type: String,
        default: new Date().toISOString()
    }
});
exports.Profile = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    imageUrl: {
        type: String,
    },
    name: {
        type: String,
        required: true
    },
    address: {
        type: String,
    },
    card_number: {
        type: String
    }
});
