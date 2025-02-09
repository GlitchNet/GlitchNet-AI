require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const config = {
  solidity: "0.8.19",
  networks: {
    ethereum: {
      url: process.env.ETH_RPC,
      accounts: [process.env.DEPLOYER_KEY]
    },
    polygon: {
      url: process.env.POLYGON_RPC,
      accounts: [process.env.DEPLOYER_KEY]
    },
    arbitrum: {
      url: process.env.ARB_RPC,
      accounts: [process.env.DEPLOYER_KEY]
    }
  },
  etherscan: {
    apiKey: {
      mainnet: process.env.ETHERSCAN_KEY,
      polygon: process.env.POLYGONSCAN_KEY,
      arbitrum: process.env.ARBISCAN_KEY
    }
  },
  paths: {
    artifacts: "./chain-artifacts",
    tests: "./multi-chain-tests"
  }
};

module.exports = config;
