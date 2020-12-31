// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./Rights.sol";

contract Tokens is ERC721 {
  struct LendingInfo {
    address rightAddress;
    uint256 until;
  }

  struct Token {
    string defaultName;
    LendingInfo lending;
  }
  Token[] private _tokens;

  constructor() ERC721("Namer", "NAMER") {}

  function lent(uint256 tokenId, uint64 duration) public {
    Token memory token = _tokens[tokenId];
    uint256 now = block.timestamp;

    require(token.lending.until < now);
    uint256 until = now + duration;
    token.lending = LendingInfo(msg.sender, until);
  }

  function publish(string calldata uri, string calldata defaultName) public returns (uint256) {
    uint256 newItemId = _tokens.length;
    _tokens.push(Token(defaultName, LendingInfo(address(0), 0)));

    _mint(msg.sender, newItemId);
    _setTokenURI(newItemId, uri);

    return newItemId;
  }
}
