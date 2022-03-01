// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "./ItemManager.sol";

contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }
    // https://blogs.thebitx.com/index.php/2021/10/25/what-is-payable-in-solidity/
    receive() external payable {
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payment wallowed already");
        pricePaid += msg.value;
        (bool success,) = address(parentContract).call{value: msg.value}(abi.encodeWithSignature("triggerPayment(uint(256)", index));
        require(success, "the transaction wasn't successful, canceling");
    }

    fallback() external {}
}