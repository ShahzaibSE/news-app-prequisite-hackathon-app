import mongoose, {Schema} from "mongoose";

export const User:Schema  = new Schema({
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

export const Favourite = new Schema({
    uid: {
        type: String,
        required: true
    },
    favourites: {
        type: Array,
        default: []
    }
});

export const Profile = new Schema({
    imageUrl: {
        type: String,
    },
    name: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    card_number: {
        type: String
    }
});