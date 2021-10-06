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
exports.Favourite = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    favourites: {
        type: Array,
        default: []
    }
});
exports.Profile = new mongoose_1.Schema({});
