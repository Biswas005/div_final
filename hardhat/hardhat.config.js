require('@nomiclabs/hardhat-ethers')
const API_URL = "https://polygon-mumbai.g.alchemy.com/v2/IigFr15mxk11noHnS-_BSdfvBb5srVpI";
const PRIVATE_KEY = "8e9ecfe3844dec1cad706e306b48e415ea34eacd377b786e2fa7902575486bf6"
const PUBLIC_KEY = "0xF2c49A8eC26e9019aafEc284F6eB5EfFF0A95245";
module.exports = {
  solidity: "0.8.0",
  defaultNetwork: "polygon mumbai",
  networks: {
    hardhat:{},
    polygon:{
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  }
};