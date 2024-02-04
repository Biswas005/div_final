// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./AccessControlContract.sol";

contract AIModelManagementContract is Ownable {
    AccessControlContract private accessControl;

    struct AIModel {
        address owner;
        string ipfsHash;
        string name;
        string description;
    }

    AIModel[] public models;

    event ModelRegistered(uint indexed modelId, address indexed owner, string ipfsHash, string name, string description);
    event ModelUpdated(uint indexed modelId, string ipfsHash, string name, string description);

    constructor(address _accessControlAddress) Ownable() {
        accessControl = AccessControlContract(_accessControlAddress);
    }

    // Function to register a new AI model
    function registerModel(string memory ipfsHash, string memory name, string memory description) public {
        require(accessControl.hasRole(accessControl.UPLOADER_ROLE(), msg.sender), "Caller does not have uploader role");
        models.push(AIModel({
            owner: msg.sender,
            ipfsHash: ipfsHash,
            name: name,
            description: description
        }));
        uint modelId = models.length - 1;
        emit ModelRegistered(modelId, msg.sender, ipfsHash, name, description);
    }

    // Function to update an AI model
    function updateModel(uint modelId, string memory ipfsHash, string memory name, string memory description) public {
        require(modelId < models.length, "Model does not exist.");
        AIModel storage model = models[modelId];
        require(msg.sender == model.owner || accessControl.hasRole(accessControl.EDITOR_ROLE(), msg.sender), "Caller is not owner nor has editor role");
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
