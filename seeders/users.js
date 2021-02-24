const { PrismaClient } = require("@prisma/client");
const chalk = require("chalk");
const bcrypt = require("bcryptjs");

const prisma = new PrismaClient();

const makeHashword = async (str) => {
    return await bcrypt.hash(str, 10);
}

const seedUsers = async () => {
    console.log(chalk.yellow("Seeding Users..."));
    users = []
    for (let i = 1; i <= 4; i++) {
        let hashword = await makeHashword(`demo${i}@login@demo${i}`)
        users.push({
            username: `demo${i}`,
            email: `demo${i}@demo.io`,
            hashword, 
        })
    }

    await prisma.user.createMany({
        data: users,
    });

    await prisma.$disconnect();
    console.log("");
    console.log("");
    console.log(chalk.green('Finished Seeding Users.'));
    console.log("");
}

seedUsers();