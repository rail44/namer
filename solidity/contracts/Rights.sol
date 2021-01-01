// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Rights is ERC721 {
  address private _originAddress;
  mapping(uint256 => uint256) private _expireMap;

  struct Token {
    string currentName;
  }
  Token[] private _tokens;

  constructor() ERC721("Namer Rights", "NMR") {
    _originAddress = msg.sender;
  }

  function setName(uint256 tokenId, string calldata name) public {
    address owner = ownerOf(tokenId);
    require(msg.sender == owner, "Not owner of token");

    _tokens[tokenId].currentName = name;
  }

  function publish(uint256 originId, uint256 duration) public returns (uint256) {
    require(msg.sender == _originAddress, "Sender is not Origin");

    uint256 currentTime = block.timestamp;
    require(_expireMap[originId] < currentTime, "Other Rights are still alive");

    _expireMap[originId] = currentTime + duration;
    _tokens.push(Token(""));
    uint256 newItemId = _tokens.length;

    _mint(msg.sender, newItemId);

    return newItemId;
  }
}
