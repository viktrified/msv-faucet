// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./lib/Errors.sol";

contract MSVNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    mapping(address => bool) private _hasMinted;

    constructor() ERC721("MSV NFT", "MSV") {}

    function mintNFT(
        address recipient,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        if (_hasMinted[recipient]) revert Errors.hasMinted();

        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        _hasMinted[recipient] = true;

        return newItemId;
    }
}
