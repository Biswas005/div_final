// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IPFSStorageContract {
    // Model structure to hold the owner address and the IPFS hash
    struct Model {
        address owner;
        string ipfsHash;
    }

    // Mapping from model ID to the Model struct
    mapping(uint256 => Model) public models;

    // Event emitted when a new model is added
    event ModelAdded(uint256 indexed modelId, address indexed owner, string ipfsHash);

    // Event emitted when a model's IPFS hash is updated
    event ModelUpdated(uint256 indexed modelId, string newIpfsHash);

    // Function to add a new model
    function addModel(uint256 modelId, string memory ipfsHash) public {
        require(models[modelId].owner == address(0), "Model already exists.");

        models[modelId] = Model(msg.sender, ipfsHash);
        emit ModelAdded(modelId, msg.sender, ipfsHash);
    }

    // Function to update the IPFS hash of an existing model
    function updateModel(uint256 modelId, string memory newIpfsHash) public {
        require(models[modelId].owner == msg.sender, "Only the owner can update the model.");
        
        models[modelId].ipfsHash = newIpfsHash;
        emit ModelUpdated(modelId, newIpfsHash);
    }

    // Function to get the IPFS hash of a model
    function getModelIpfsHash(uint256 modelId) public view returns (string memory) {
        require(models[modelId].owner != address(0), "Model does not exist.");
        
        return models[modelId].ipfsHash;
    }
}
