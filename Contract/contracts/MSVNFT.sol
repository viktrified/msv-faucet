// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./lib/Errors.sol";
import "./lib/Events.sol";

contract MSVNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    mapping(address => bool) private _hasMinted;

    constructor() ERC721("MSV NFT", "MSV") {}

    function mintNFT(
        string memory tokenURI, 
    ) public onlyOwner returns (uint256) {
        if (_hasMinted[msg.sender]) revert Errors.hasMinted();
        if(msg.value !>= 0.05 ether) revert Errors.NotEnoughMintingFee();

        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        _hasMinted[msg.sender] = true;

        emit Events.Mint(msg.sender, newItemId);
        return newItemId;
    }
}
