"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.dbInjector = void 0;
const model_1 = require("./../model");
const mongoose_1 = __importDefault(require("mongoose"));
const dbInjector = () => ({
    user: mongoose_1.default.model('User', model_1.User),
    favourite: mongoose_1.default.model('Favourite', model_1.Favourite),
    profile: mongoose_1.default.model('Profile', model_1.Profile)
});
exports.dbInjector = dbInjector;
