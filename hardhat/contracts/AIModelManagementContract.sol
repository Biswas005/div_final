// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./AccessControlContract.sol";

contract AIModelManagementContract is Ownable {
    // Structure to represent an AI model
    struct AIModel {
        address owner;
        string ipfsHash;
        string name;
        string description;
    }

    // Array to store all AI models
    AIModel[] public models;

    // Access control contract instance
    AccessControlContract accessControl;

    // Event to emit when a new model is registered
    event ModelRegistered(uint indexed modelId, address indexed owner, string ipfsHash, string name, string description);
    // Event to emit when a model is updated
    event ModelUpdated(uint indexed modelId, string ipfsHash, string name, string description);

    constructor(address _accessControlAddress) {
        accessControl = AccessControlContract(_accessControlAddress);
    }

    // Function to register a new AI model
    function registerModel(string memory ipfsHash, string memory name, string memory description) public {
        require(accessControl.hasRole(accessControl.UPLOADER_ROLE(), msg.sender), "Caller does not have uploader role");
        models.push(AIModel(msg.sender, ipfsHash, name, description));
        uint modelId = models.length - 1;
        emit ModelRegistered(modelId, msg.sender, ipfsHash, name, description);
    }

    // Function to update an AI model
    function updateModel(uint modelId, string memory ipfsHash, string memory name, string memory description) public {
        require(modelId < models.length, "Model does not exist.");
        AIModel storage model = models[modelId];
        require(msg.sender == model.owner || accessControl.hasRole(accessControl.EDITOR_ROLE(), msg.sender), "Caller is not owner or does not have editor role");
        model.ipfsHash = ipfsHash;
        model.name = name;
        model.description = description;
        emit ModelUpdated(modelId, ipfsHash, name, description);
    }

    // Function to retrieve AI model details
    function getModel(uint modelId) public view returns (AIModel memory) {
        require(modelId < models.length, "Model does not exist.");
        return models[modelId];
    }
}
