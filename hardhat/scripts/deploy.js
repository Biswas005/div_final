// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {
    // Retrieve accounts from the local node
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    
    // Deploy AccessControlContract
    const AccessControl = await ethers.getContractFactory("AccessControlContract");
    const accessControl = await AccessControl.deploy(deployer.address);
    
    // Wait for the transaction to be mined
    //await accessControl.deployTransaction.wait();
    console.log("AccessControlContract deployed to:", accessControl.address);

    // Deploy AIModelManagementContract
    const AIModelManagement = await ethers.getContractFactory("AIModelManagementContract");
    const aiModelManagement = await AIModelManagement.deploy(accessControl.address); // Passing AccessControlContract's address
    await aiModelManagement.deployTransaction.wait(); // Wait for the deployment transaction to be mined
    console.log("AIModelManagementContract deployed to:", aiModelManagement.address);

    // Deploy ModelDeploymentContract
    const ModelDeployment = await ethers.getContractFactory("ModelDeploymentContract");
    const modelDeployment = await ModelDeployment.deploy(); // Add constructor arguments if there are any
    await modelDeployment.deployTransaction.wait(); // Wait for the deployment transaction to be mined
    console.log("ModelDeploymentContract deployed to:", modelDeployment.address);

    // Add other contract deployments if necessary
    // ...
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
