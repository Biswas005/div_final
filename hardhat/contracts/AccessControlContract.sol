// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AccessControlContract is Ownable {
    mapping(bytes32 => mapping(address => bool)) public roles;

    // Define constants for role identifiers
    bytes32 public constant UPLOADER_ROLE = keccak256("UPLOADER_ROLE");
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");
    // Add more roles as necessary

    event RoleGranted(bytes32 indexed role, address indexed account);
    event RoleRevoked(bytes32 indexed role, address indexed account);

    // Grant a role to an address
    function grantRole(bytes32 role, address account) public onlyOwner {
        roles[role][account] = true;
        emit RoleGranted(role, account);
    }

    // Revoke a role from an address
    function revokeRole(bytes32 role, address account) public onlyOwner {
        roles[role][account] = false;
        emit RoleRevoked(role, account);
    }

    // Modifier to use in other contracts or functions to restrict access
    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender], "Not authorized");
        _;
    }
}
