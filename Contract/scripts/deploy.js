const hre = require("hardhat");

async function main() {
    const MsvToken = await hre.ethers.getContractFactory("MsvToken")
    const msvToken = await MsvToken.deploy(100000000, 50);

    await msvToken.waitForDeployment();

    console.log("MSV Token deployed: ", msvToken.address)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});



