const { ethers } = require("hardhat");

async function rotateContract() {
    const [operator] = await ethers.getSigners();
    const contract = await ethers.getContractAt(
        "DynamicFlawedContract",
        process.env.CONTRACT_ADDRESS
    );

    const tx = await contract.connect(operator).forceRotation();
    await tx.wait();
    
    console.log(`Contract rotated at block ${tx.blockNumber}`);
}

// Simulate AI decision making
function shouldRotate() {
    const chaosFactors = [
        Math.random() > 0.5,
        Date.now() % 2 === 0,
        process.env.CHAOS_MODE === "true"
    ];
    return chaosFactors.some(f => f);
}

module.exports = { rotateContract, shouldRotate };
