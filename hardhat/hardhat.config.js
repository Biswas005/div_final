require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Import dotenv to use your .env variables

const { API_URL, PRIVATE_KEY } = process.env; // Access environment variables

module.exports = {
  solidity: "0.8.20",
  networks: {
    mumbai: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  }
};