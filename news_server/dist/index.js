"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const server_1 = __importDefault(require("./server"));
const port = Number(process.env.PORT || 3000);
const server = server_1.default.listen(port, () => {
    console.log("|======================================|");
    console.log(`|=====================Server started on ${port}=================|`);
    console.log("|======================================|");
});
