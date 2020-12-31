const hre = require("hardhat");
const ethers = hre.ethers;

async function deployTokens() {
  const Tokens = await ethers.getContractFactory("Tokens");
  const trx = await Tokens.deploy();
  await trx.deployed();

  console.log("Tokens deployed to:", trx.address);
}

async function deployRights() {
  const Rights = await ethers.getContractFactory("Rights");
  const trx = await Rights.deploy();
  await trx.deployed();

  console.log("Rights deployed to:", trx.address);
}

deployTokens()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

deployRights()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
