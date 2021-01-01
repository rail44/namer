const hre = require("hardhat");
const ethers = hre.ethers;

async function deployOrigins() {
  const Origins = await ethers.getContractFactory("Origins");
  const trx = await Origins.deploy();
  await trx.deployed();

  console.log("Origins deployed to:", trx.address);
}

deployOrigins();
