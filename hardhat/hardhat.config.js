require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Import dotenv to use your .env variables

const { POLYGON_MUMBAI_URL, PRIVATE_KEY } = process.env; // Access environment variables

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    polygon_mumbai: { // Correct network name
      url: POLYGON_MUMBAI_URL,
      accounts: [`0x${PRIVATE_KEY}`] // Correctly format the private key
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
};
