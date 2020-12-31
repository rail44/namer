// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Tokens is ERC721 {
  struct Token {
    string defaultName;
  }
  Token[] private _tokens;

  constructor() ERC721("Namer", "NAMER") {}

  function lent() public {}

  function publish(string calldata uri, string calldata defaultName) public returns (uint256) {
    uint256 newItemId = _tokens.length;
    _tokens.push(Token(defaultName));

    _mint(msg.sender, newItemId);
    _setTokenURI(newItemId, uri);

    return newItemId;
  }
}
