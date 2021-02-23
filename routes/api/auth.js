const express = require("express");
const asyncHandler = require("express-async-handler");
const bcrypt = require("bcryptjs");
const { PrismaClient } = require("@prisma/client");
const { getUserToken, requireAuth, validatePassword } = require("../../auth");

const prisma = new PrismaClient();
const router = express.Router();

// auth route
router.get(
    "/auth",
    requireAuth,
    asyncHandler(async (req, res, next) => {
        res.status(200);
        res.send({
        message: "OK",
        user: req.user,
        });
    })
);

// sign up route
router.post(
    "/",
    asyncHandler(async (req, res, next) => {
        const { username, password, email } = req.body;
        const hashword = await bcrypt.hash(password, 10);
        try {
            const user = await prisma.user.create({
            data: {
                username,
                hashword,
                email,
            },
            select: {
                id: true,
                username: true,
                email: true,
                decks: true,
                deckLikes: true,
            },
        });
        const token = getUserToken(user);
        res.cookie("token", token, { httpOnly: true });
        res.json({
            user,
            });
        } catch (e) {
            if (e.code === "P2002") {
                res.json({ message: "Username or Email in use.", e });
            } else {
                res.json({ message: "Error...", e });
            }
        }
    })
);

// login route
router.post(
    "/login",
    asyncHandler(async (req, res, next) => {
        const { username, password } = req.body;
        const login = await prisma.user.findUnique({
            where: {
                username,
            },
            include: {
                decks: {
                select: {
                    id: true,
                    name: true,
                    format: true,
                    wins: true,
                    losses: true,
                    imgUrl: true,
                    userId: true,
                },
                },
                deckLikes: {
                include: {
                    deck: {
                    select: {
                        id: true,
                        name: true,
                        wins: true,
                        losses: true,
                        format: true,
                        imgUrl: true,
                        userId: true,
                    },
                    },
                },
                },
                commentLikes: {
                include: {
                    comment: {
                    select: {
                        id: true,
                    },
                    },
                },
                },
            },
        });
        if (!login || !validatePassword(password, login)) {
            const err = new Error("Login failed");
            err.status = 401;
            err.title = "Login Failed";
            err.errors = ["The provided credentials were invalid"];
            return next(err);
        }
        const user = Object.assign({}, { ...login });
        delete user.hashword;
        const token = getUserToken(login);
        res.cookie("token", token, { httpOnly: true });
        res.json({ user });
    })
);

// lougout route
router.patch(
    "/logout",
    requireAuth,
    asyncHandler(async (req, res, next) => {
        res.clearCookie("token");
        res.json({ message: "logged out successfully" });
    })
);

module.exports = router;