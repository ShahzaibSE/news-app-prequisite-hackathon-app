import express, {Router} from "express";
import app from "./../server";
// Controllers.
import {
    createProfile, updateProfile, getProfile 
} from "./../controllers/profile.controller";

const profile_router: Router = Router();

profile_router.get('/yourprofile/:uid', getProfile);
profile_router.post('/create', createProfile);
profile_router.put('/edit', updateProfile)

export default profile_router;