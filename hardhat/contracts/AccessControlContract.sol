// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AccessControlContract is AccessControl, Ownable {
    // Define role constants
    bytes32 public constant UPLOADER_ROLE = keccak256("UPLOADER_ROLE");
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");

    // Constructor sets up the default admin role
    constructor(address initialOwner) Ownable() {
        // Transfer ownership to the initialOwner
        transferOwnership(initialOwner);

        // Grant the contract deployer (initial owner) the default admin role: they can grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, initialOwner);

        // Set up role admins
        _setRoleAdmin(UPLOADER_ROLE, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(EDITOR_ROLE, DEFAULT_ADMIN_ROLE);
    }

    // Override grantRole, revokeRole, and renounceRole to include onlyRole modifier for access control
    // These functions are already defined in AccessControl, so they are being overridden here
    // to include custom logic or restrictions if necessary

    // Grant a role to a specific account
    function grantRole(bytes32 role, address account) public override onlyRole(getRoleAdmin(role)) {
        super.grantRole(role, account);
    }

    // Revoke a role from a specific account
    function revokeRole(bytes32 role, address account) public override onlyRole(getRoleAdmin(role)) {
        super.revokeRole(role, account);
    }

    // Renounce a role from the calling account
    function renounceRole(bytes32 role, address account) public override {
        super.renounceRole(role, account);
    }

    // In case the OpenZeppelin's AccessControl functions are not recognized, we'll explicitly set them
    function _setupRole(bytes32 role, address account) internal override {
        super._setupRole(role, account);
    }

    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal override {
        super._setRoleAdmin(role, adminRole);
    }
}
