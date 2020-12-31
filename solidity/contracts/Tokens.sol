// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./Rights.sol";

contract Tokens is ERC721 {
  struct Token {
    string defaultName;
    string url;
  }
  Token[] private _tokens;

  constructor() ERC721("Blank", "BLANK") {}

  function lent(uint256 tokenId, uint64 duration) public {
    Rights Rights = new Rights();
    Rights.publish(msg.sender, tokenId, duration);
  }

  function publish(string calldata url, string calldata defaultName) public returns (uint256) {
    _tokens.push(Token(defaultName, url));
    uint256 newItemId = _tokens.length;

    _mint(msg.sender, newItemId);
    return newItemId;
  }
}
