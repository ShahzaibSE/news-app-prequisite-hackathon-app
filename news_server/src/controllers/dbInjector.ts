import {User, Favourite, Profile} from "./../model";
import mongoose from "mongoose";

export const dbInjector = () => ({
    user: mongoose.model('User', User),
    favourite: mongoose.model('Favourite', Favourite),
    profile: mongoose.model('Profile', Profile)
});