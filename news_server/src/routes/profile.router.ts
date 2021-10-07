import express, {Router} from "express";
import app from "./../server";
// Controllers.
import {
    createProfile, updateProfile
} from "./../controllers/profile.controller";
import { profile } from "console";

const profile_router: Router = Router();

profile_router.post('/create', createProfile);
profile_router.put('/edit', updateProfile)

export default profile_router;