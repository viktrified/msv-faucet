// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

library Events {
    event Mint(address recipient, uint tokenId);
    event Withdraw(uint amount, address recipient);
    event Deposit(uint _amount, address sender);
    event Claimed(uint claimer);
}
