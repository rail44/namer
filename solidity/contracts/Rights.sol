// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./Tokens.sol";

contract Rights is ERC721 {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  constructor() ERC721("Namer", "NAMER") {}

  function publish(address author) public returns (uint256) {
    require(msg.sender == address(Tokens));
    uint256 newItemId = _tokenIds.current();

    _mint(author, newItemId);
    _tokenIds.increment();

    return newItemId;
  }
}
