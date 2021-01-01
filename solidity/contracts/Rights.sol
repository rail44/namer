// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Rights is ERC721 {
    address private _originAddress;
    mapping(uint256 => uint256) private _expireMap;

    struct Token {
        uint256 originId;
        string currentName;
    }
    Token[] private _tokens;

    constructor() ERC721("Namer Rights", "NMR") {
        _originAddress = msg.sender;
    }

    function currentName(uint256 tokenId) public view returns (string memory) {
        require(isEnable(tokenId));
        return _tokens[tokenId].currentName;
    }

    function isEnable(uint256 tokenId) public view returns (bool) {
        uint256 originId = _tokens[tokenId].originId;
        return _expireMap[originId] < block.timestamp;
    }

    function setName(uint256 tokenId, string calldata name) public {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner, "Not owner of token");

        _tokens[tokenId].currentName = name;
    }

    function publish(uint256 originId, uint64 duration) public returns (uint256) {
        require(msg.sender == _originAddress, "Sender is not Origin");

        uint64 currentTime = uint64(block.timestamp);
        require(_expireMap[originId] < currentTime, "Other Rights are still alive");

        _expireMap[originId] = currentTime + duration;
        _tokens.push(Token(originId, ""));
        uint256 newItemId = _tokens.length;

        _mint(msg.sender, newItemId);

        return newItemId;
    }
}
