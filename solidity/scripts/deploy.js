const hre = require("hardhat");
const ethers = hre.ethers;

async function deployOrigins() {
  const Origins = await ethers.getContractFactory("Origins");
  const trx = await Origins.deploy();
  await trx.deployed();

  console.log("Origins deployed to:", trx.address);
}

async function deployRights() {
  const Rights = await ethers.getContractFactory("Rights");
  const trx = await Rights.deploy();
  await trx.deployed();

  console.log("Rights deployed to:", trx.address);
}

deployOrigins()
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

// deployRights()
//   .catch(error => {
//     console.error(error);
//     process.exit(1);
//   });
