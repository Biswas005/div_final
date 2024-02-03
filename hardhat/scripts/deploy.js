// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {
    // Retrieve accounts from the local node
    const accounts = await ethers.getSigners();
    
    // Deploy AccessControlContract
    const AccessControl = await ethers.getContractFactory("AccessControlContract");
    const accessControl = await AccessControl.deploy();
    await accessControl.deployed();
    console.log("AccessControlContract deployed to:", accessControl.address);

    // Deploy AIModelManagementContract
    const AIModelManagement = await ethers.getContractFactory("AIModelManagementContract");
    const aiModelManagement = await AIModelManagement.deploy(accessControl.address); // Passing AccessControlContract's address
    await aiModelManagement.deployed();
    console.log("AIModelManagementContract deployed to:", aiModelManagement.address);

    // Deploy ModelDeploymentContract
    const ModelDeployment = await ethers.getContractFactory("ModelDeploymentContract");
    const modelDeployment = await ModelDeployment.deploy();
    await modelDeployment.deployed();
    console.log("ModelDeploymentContract deployed to:", modelDeployment.address);

    // Deploy IPFSStorageContract
    const IPFSStorage = await ethers.getContractFactory("IPFSStorageContract");
    const ipfsStorage = await IPFSStorage.deploy(); // Add constructor arguments if there are any
    await ipfsStorage.deployed();
    console.log("IPFSStorageContract deployed to:", ipfsStorage.address);
    
    // Additional steps can be added here if you need to set up relationships between contracts
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
