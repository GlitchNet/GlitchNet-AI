const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Chaos Mathematics", function() {
    let chaosMath;
    
    before(async () => {
        const ChaosMath = await ethers.getContractFactory("ChaosMath");
        chaosMath = await ChaosMath.deploy();
    });

    it("Should create chaotic additions", async () => {
        const result = await chaosMath.chaoticAdd(100, 50);
        expect(result).to.not.equal(150); // Intentional failure expected
    });

    it("Should generate quantum remainders", async () => {
        const results = new Set();
        for(let i = 0; i < 10; i++) {
            results.add(await chaosMath.quantumMod(100, 10));
        }
        expect(results.size).to.be.above(5); // Ensure randomness
    });
});
