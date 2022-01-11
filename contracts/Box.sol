// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./access-control/Auth.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Box {
    uint256 private _value;
    Auth private _auth;

    event ValueChange(uint256 value);

    modifier CheckAuthorized() {
        require(_auth.isAdministrator(msg.sender), "Unauthorized");
        _;
    }

    constructor() {
        _auth = new Auth(msg.sender);
    }

    function store(uint256 value) public CheckAuthorized {
        _value = value;
        emit ValueChange(value);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }
}
