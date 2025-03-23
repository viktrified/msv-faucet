// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC71/ERC721.sol";
// import {MSVNFT} from "./MSVNFT.sol";
import "./lib/Errors.sol";
import "./lib/Events.sol";

contract Faucet is Ownable {
    address nft;
    mapping(address => bool) hasClaimed;

    constructor(address _nft) {
        nft = _nft;
    }

    function addBaseSepolia(uint _amount) public {
        if (_amount <= 0) revert Errors.InvalidDepositAmount();
        msg.sender.transfer(_amount, address(this));

        emit Deposit(_amount, msg.sender);
    }

    function withdrawAllBaseSepolia() public OnlyOwner {
        if (address(this).balance <= 0) revert Errors.InsufficientFunds();
        address(this).transfer(address(this).balance, msg.sender);

        emit Withdraw(address(this).balance, msg.sender);
    }

    function withdrawBaseSepolia(uint _amount) public OnlyOwner {
        if (address(this).balance <= 0) revert Errors.InsufficientFunds();
        if (address(this).balance < _amount)
            revert Errors.GreatherThanBalance();
        address(this).transfer(_amount, msg.sender);

        emit Withdraw(_amount, msg.sender);
    }

    function claimSepolia() public {
        if (!nft.balanceOf(msg.sender)) revert Errors.DontHaveNFT();
        if (hasClaimed[msg.sender] && block.timestamp > 24 hours)
            revert Errors.HasClaimed();
        address(this).transfer(0.001, msg.sender);
        
        emit Claimed(msg.sender);
    }
}

// DONT FORGET TO PRIVATE THE MERKLE AIRDROP REPO
