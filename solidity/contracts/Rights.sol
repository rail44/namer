// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./Tokens.sol";

contract Rights is ERC721 {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  struct Token {
    uint256 id;
    string currentName;
    uint256 expire;
  }
  mapping(uint256 => Token) private _tokenMap;

  constructor() ERC721("Namer", "NAMER") {}

  function publish(address author, uint256 origin, uint256 duration) public returns (uint256) {
    // require(msg.sender == address(new Tokens()));

    uint256 now = block.timestamp;
    Token memory existing = _tokenMap[origin];
    require(existing.expire > now);

    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();

    _tokenMap[origin] = Token(newItemId, "", now + duration);

    _mint(msg.sender, newItemId);
    return newItemId;
  }
}
