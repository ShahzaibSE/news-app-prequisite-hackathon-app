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

export const Favourite = new Schema({
    uid: {
        type: String,
        required: true
    },
    title: {
        type: String
    },
    description: {
        type: String
    },
    image:{
        type: String
    },
    video:{
        type: String
    },
    time:{
        type: String
    },
    published_at:{
        type: String
    },
    category:{
        type: String
    },
    author:{
        type: String
    },
    url:{
        type: String
    },
    source:{
        type: String
    },
    country:{
        type: String
    },
    createdAt: {
        type: String,
        default: new Date().toISOString()
    }
})

export const Profile = new Schema({
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