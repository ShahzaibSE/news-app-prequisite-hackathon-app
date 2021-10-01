import {User} from "./../model";
import mongoose from "mongoose";

export const dbInjector = () => ({
    user: mongoose.model('User', User),
});