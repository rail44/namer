const hre = require("hardhat");
const ethers = hre.ethers;

async function deploy() {
  const Tokens = await ethers.getContractFactory("Tokens");
  const trx = await Tokens.deploy();
  await trx.deployed();

  console.log("Tokens deployed to:", trx.address);
}

deploy()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
