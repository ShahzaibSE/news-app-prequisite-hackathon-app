"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
// Controllers.
const profile_controller_1 = require("./../controllers/profile.controller");
const profile_router = express_1.Router();
profile_router.get('/yourprofile/:uid', profile_controller_1.getProfile);
profile_router.post('/create', profile_controller_1.createProfile);
profile_router.put('/edit', profile_controller_1.updateProfile);
exports.default = profile_router;
