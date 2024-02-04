// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ModelDeploymentContract is Ownable {
    struct DeployedModel {
        address owner;
        string ipfsHash; // IPFS hash where the model is stored
        string metadata; // Additional metadata or description of the model
        bool isActive; // Whether the model is active and usable
    }

    DeployedModel[] public deployedModels;

    event ModelDeployed(uint indexed modelId, address indexed owner, string ipfsHash, string metadata);
    event ModelStatusUpdated(uint indexed modelId, bool isActive);

    // Constructor
    constructor() Ownable() {}

    // Function to deploy a new model
    function deployModel(string memory ipfsHash, string memory metadata) public {
        DeployedModel memory newModel = DeployedModel({
            owner: msg.sender,
            ipfsHash: ipfsHash,
            metadata: metadata,
            isActive: true
        });
        deployedModels.push(newModel);
        emit ModelDeployed(deployedModels.length - 1, msg.sender, ipfsHash, metadata);
    }

    // Function to update model status (e.g., activate/deactivate)
    function updateModelStatus(uint modelId, bool isActive) public {
        require(modelId < deployedModels.length, "Model does not exist.");
        DeployedModel storage model = deployedModels[modelId];
        require(msg.sender == model.owner, "Caller is not the owner of the model.");

        model.isActive = isActive;
        emit ModelStatusUpdated(modelId, isActive);
    }

    // Function to retrieve deployed model details
    function getDeployedModel(uint modelId) public view returns (DeployedModel memory) {
        require(modelId < deployedModels.length, "Model does not exist.");
        return deployedModels[modelId];
    }
}
