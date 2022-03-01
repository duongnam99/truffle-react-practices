// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Ownable {
    address _owner;

    constructor() payable {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "You are not the owner");
        _;
    }

    function isOwner() public view returns (bool) {
        return _owner == msg.sender;
    }

}