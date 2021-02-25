const express = require("express");
const asyncHandler = require("express-async-handler");
const { PrismaClient } = require("@prisma/client");
const { requireAuth } = require("../../auth");
const { parse } = require("path");
const { query } = require("express-validator");

const prisma = new PrismaClient();
const router = express.Router();

// get all songs basic info by popularity
router.get(
    "/",
    asyncHandler(async (req, res, next) => {
        const songs = await prisma.song.findMany({
            include: { 
                artist: {
                    select: {
                        id: true,
                        name: true
                    }
                },
                posted_by: {
                    select: {
                        id: true,
                        username: true,
                    }
                },
                liked_by: {
                    select: {
                        id: true,
                        username: true,
                    },
                },
                disliked_by: {
                    select: {
                        id: true,
                        username: true,
                    }
                },
            },
        })
    })
)

